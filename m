Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1614A7743D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjHHSKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjHHSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:10:22 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78001160AE9;
        Tue,  8 Aug 2023 10:13:12 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1691503677; bh=JCNxuh7snRK2UxJGDtGrIxZbmzWs6fAjEgbNbIIekR8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=wizfIvOD0Xel224akMYsYN2NAFu/z8AWfHMpuPb6xqrHKSjejQhOalNbVLjtbrCvP
         c/aGldFz6MmxcsAfpne4d1lPZMY5f4Q/fjdw8DbX+hZDhU6PMxEAVGjU+8EELiNb8G
         I22pBkwsDBQra2XKcWihEUdCelKCVxrhBya0JIT8K2CM0+E5qkPWTo10SgRv+kQCxl
         MDGnO7O3lTfIiw+QV4cPlUNCkLrwxLBLw6mEuH1EYp3yJostPLnyrgB0V9IoJIC4Lv
         WlBoU3ytvhzutDC9N8uf9oLhudBBgN9xbctm9hlvPHkcylTGWurHQbxeXMHo1Ixzn/
         fHNcREXn8JrUg==
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
Subject: Re: [PATCH v3 2/2] wifi: ath9k: protect WMI command response buffer
 replacement with a lock
In-Reply-To: <20230425192607.18015-2-pchelkin@ispras.ru>
References: <20230425192607.18015-1-pchelkin@ispras.ru>
 <20230425192607.18015-2-pchelkin@ispras.ru>
Date:   Tue, 08 Aug 2023 16:07:57 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87bkfhbpaa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fedor Pchelkin <pchelkin@ispras.ru> writes:

> If ath9k_wmi_cmd() has exited with a timeout, it is possible that during
> next ath9k_wmi_cmd() call the wmi_rsp callback for previous wmi command
> writes to new wmi->cmd_rsp_buf and makes a completion. This results in an
> invalid ath9k_wmi_cmd() return value.
>
> Move the replacement of WMI command response buffer and length under
> wmi_lock. Note that last_seq_id value is updated there, too.
>
> Thus, the buffer cannot be written to by a belated wmi_rsp callback
> because that path is properly rejected by the last_seq_id check.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Given that the previous patch resets the last_seq_id to 0 on timeout
under the lock, I don't think this patch is strictly necessary anymore.
However, it doesn't hurt either, and I actually think moving the update
of the rsp buf into ath9k_wmi_cmd_issue() aids readability, so:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
