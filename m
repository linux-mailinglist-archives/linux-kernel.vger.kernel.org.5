Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F4B77D4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbjHOVM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbjHOVMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE71FDD;
        Tue, 15 Aug 2023 14:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A351644E3;
        Tue, 15 Aug 2023 21:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2F5C433C7;
        Tue, 15 Aug 2023 21:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692133920;
        bh=2WHO3Azi8wuEwIIFGRq8KK6wHH/40wZAHhZzEFKUpZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8oACwOg+Qtvb4xE//69OkNWr1TDwka2uQ/ln54WjxSjdacX1e/PGfANU3WtqMroz
         fZFLR7u3PbtAjeF0DrjN0M2eI6oP+KhrfSFS0pwFt0vg3lJwg5shekWnwAI11N4E4d
         iUOzJUxdF0YXdpPvaPryxGNQQWiBgNf0/M/c+DWE=
Date:   Tue, 15 Aug 2023 23:11:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Kanner <andrew.kanner@gmail.com>
Cc:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, selinux@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selinux: netlabel: Prevent KMSAN warning in
 selinux_inet_conn_request()
Message-ID: <2023081532-laundry-pull-87ed@gregkh>
References: <20230815205917.1504837-1-andrew.kanner@gmail.com>
 <20230815205917.1504837-2-andrew.kanner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815205917.1504837-2-andrew.kanner@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:59:17PM +0200, Andrew Kanner wrote:
> KMSAN reports the following issue:
> [   81.822503] =====================================================
> [   81.823222] BUG: KMSAN: uninit-value in selinux_inet_conn_request+0x2c8/0x4b0
> [   81.823891]  selinux_inet_conn_request+0x2c8/0x4b0
> [   81.824385]  security_inet_conn_request+0xc0/0x160
> [   81.824886]  tcp_v4_route_req+0x30e/0x490
> [   81.825343]  tcp_conn_request+0xdc8/0x3400
> [   81.825813]  tcp_v4_conn_request+0x134/0x190
> [   81.826292]  tcp_rcv_state_process+0x1f4/0x3b40
> [   81.826797]  tcp_v4_do_rcv+0x9ca/0xc30
> [   81.827236]  tcp_v4_rcv+0x3bf5/0x4180
> [   81.827670]  ip_protocol_deliver_rcu+0x822/0x1230
> [   81.828174]  ip_local_deliver_finish+0x259/0x370
> [   81.828667]  ip_local_deliver+0x1c0/0x450
> [   81.829105]  ip_sublist_rcv+0xdc1/0xf50
> [   81.829534]  ip_list_rcv+0x72e/0x790
> [   81.829941]  __netif_receive_skb_list_core+0x10d5/0x1180
> [   81.830499]  netif_receive_skb_list_internal+0xc41/0x1190
> [   81.831064]  napi_complete_done+0x2c4/0x8b0
> [   81.831532]  e1000_clean+0x12bf/0x4d90
> [   81.831983]  __napi_poll+0xa6/0x760
> [   81.832391]  net_rx_action+0x84c/0x1550
> [   81.832831]  __do_softirq+0x272/0xa6c
> [   81.833239]  __irq_exit_rcu+0xb7/0x1a0
> [   81.833654]  irq_exit_rcu+0x17/0x40
> [   81.834044]  common_interrupt+0x8d/0xa0
> [   81.834494]  asm_common_interrupt+0x2b/0x40
> [   81.834949]  default_idle+0x17/0x20
> [   81.835356]  arch_cpu_idle+0xd/0x20
> [   81.835766]  default_idle_call+0x43/0x70
> [   81.836210]  do_idle+0x258/0x800
> [   81.836581]  cpu_startup_entry+0x26/0x30
> [   81.837002]  __pfx_ap_starting+0x0/0x10
> [   81.837444]  secondary_startup_64_no_verify+0x17a/0x17b
> [   81.837979]
> [   81.838166] Local variable nlbl_type.i created at:
> [   81.838596]  selinux_inet_conn_request+0xe3/0x4b0
> [   81.839078]  security_inet_conn_request+0xc0/0x160
> 
> KMSAN warning is reproducible with:
> * netlabel_mgmt_protocount is 0 (e.g. netlbl_enabled() returns 0)
> * CONFIG_SECURITY_NETWORK_XFRM may be set or not
> * CONFIG_KMSAN=y
> * `ssh USER@HOSTNAME /bin/date`
> 
> selinux_skb_peerlbl_sid() will call selinux_xfrm_skb_sid(), then fall
> to selinux_netlbl_skbuff_getsid() which will not initialize nlbl_type,
> but it will be passed to:
> 
>     err = security_net_peersid_resolve(nlbl_sid,
>                                        nlbl_type, xfrm_sid, sid);
> 
> and checked by KMSAN, although it will not be used inside
> security_net_peersid_resolve() (at least now), since this function
> will check either (xfrm_sid == SECSID_NULL) or (nlbl_sid ==
> SECSID_NULL) first and return before using uninitialized nlbl_type.
> 
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---
>  security/selinux/netlabel.c | 1 +
>  1 file changed, 1 insertion(+)

What git commit id does this fix?  Does it also need to go to older
kernels?  If so, how far back?

thanks,

greg k-h
