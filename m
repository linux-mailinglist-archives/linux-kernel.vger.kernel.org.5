Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB277473F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjHHTMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjHHTLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:11:46 -0400
X-Greylist: delayed 1802 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 09:33:37 PDT
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D773103C;
        Tue,  8 Aug 2023 09:33:37 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1691503571; bh=DO+diXcZ9utTjLCydk3zF1T+72EgE+BXHMNyOGRq6Ag=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ufsvvw3XC+ndybpKuDXPhTRnlV6E36AEoC6EXNd+4roQ2Jp/HEutKL5Nny90eexIl
         8iqgnPGKQs5VN8ciMrQ5/h4EptP8dN+TV0EGxphvodVJCGK2SLyrUZi1H4l5QMHepM
         2lT+STOPbPw19sL/dqJCQ5ZHC0EHX+7NrLyLcA+jyQmVELEjeKJCDVwSYRU4s38U83
         lHQPU5zX5Jluu00S52QeTfYOQU8xASQaPu796EbxAPZUgWCS/sy73wvscKGss1Sk5d
         9ob6Ai26rmgSuYxEstT2KrPzEof1DzBrHu9Tkt9YR6Ulzah58YZEdAcqwbE3BAy3xO
         wwL5gVq1sTMCQ==
To:     Fedor Pchelkin <pchelkin@ispras.ru>, Kalle Vallo <kvalo@kernel.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Senthil Balasubramanian <senthilkumar@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Vasanthakumar Thiagarajan <vasanth@atheros.com>,
        Sujith <Sujith.Manoharan@atheros.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 1/2] wifi: ath9k: fix races between ath9k_wmi_cmd and
 ath9k_wmi_ctrl_rx
In-Reply-To: <20230425192607.18015-1-pchelkin@ispras.ru>
References: <20230425192607.18015-1-pchelkin@ispras.ru>
Date:   Tue, 08 Aug 2023 16:06:07 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87edkdbpdc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fedor Pchelkin <pchelkin@ispras.ru> writes:

> Currently, the synchronization between ath9k_wmi_cmd() and
> ath9k_wmi_ctrl_rx() is exposed to a race condition which, although being
> rather unlikely, can lead to invalid behaviour of ath9k_wmi_cmd().
>
> Consider the following scenario:
>
> CPU0					CPU1
>
> ath9k_wmi_cmd(...)
>   mutex_lock(&wmi->op_mutex)
>   ath9k_wmi_cmd_issue(...)
>   wait_for_completion_timeout(...)
>   ---
>   timeout
>   ---
> 					/* the callback is being processed
> 					 * before last_seq_id became zero
> 					 */
> 					ath9k_wmi_ctrl_rx(...)
> 					  spin_lock_irqsave(...)
> 					  /* wmi->last_seq_id check here
> 					   * doesn't detect timeout yet
> 					   */
> 					  spin_unlock_irqrestore(...)
>   /* last_seq_id is zeroed to
>    * indicate there was a timeout
>    */
>   wmi->last_seq_id =3D 0
>   mutex_unlock(&wmi->op_mutex)
>   return -ETIMEDOUT
>
> ath9k_wmi_cmd(...)
>   mutex_lock(&wmi->op_mutex)
>   /* the buffer is replaced with
>    * another one
>    */
>   wmi->cmd_rsp_buf =3D rsp_buf
>   wmi->cmd_rsp_len =3D rsp_len
>   ath9k_wmi_cmd_issue(...)
>     spin_lock_irqsave(...)
>     spin_unlock_irqrestore(...)
>   wait_for_completion_timeout(...)
> 					/* the continuation of the
> 					 * callback left after the first
> 					 * ath9k_wmi_cmd call
> 					 */
> 					  ath9k_wmi_rsp_callback(...)
> 					    /* copying data designated
> 					     * to already timeouted
> 					     * WMI command into an
> 					     * inappropriate wmi_cmd_buf
> 					     */
> 					    memcpy(...)
> 					    complete(&wmi->cmd_wait)
>   /* awakened by the bogus callback
>    * =3D> invalid return result
>    */
>   mutex_unlock(&wmi->op_mutex)
>   return 0
>
> To fix this, update last_seq_id on timeout path inside ath9k_wmi_cmd()
> under the wmi_lock. Move ath9k_wmi_rsp_callback() under wmi_lock inside
> ath9k_wmi_ctrl_rx() so that the wmi->cmd_wait can be completed only for
> initially designated wmi_cmd call, otherwise the path would be rejected
> with last_seq_id check.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Alright, finally took the time to dig into this and convince myself that
the fix if correct. Sorry for taking so long!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
