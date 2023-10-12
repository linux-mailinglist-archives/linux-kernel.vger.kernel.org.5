Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8D67C6809
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjJLIxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjJLIxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:53:50 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 01:53:48 PDT
Received: from pv50p00im-ztbu10011701.me.com (pv50p00im-ztbu10011701.me.com [17.58.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D83B91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
        t=1697100370; bh=epA+w5+uiHNt1jwJmjO/DUGjYA++VzjytxtotmoxQdw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=J8z5wjYZ7wftaRZTggm1nOCS+GzXCGnJmJTtZbR/VwRhm6plRji3CsqhfkM7hTOXM
         kkhmqPlY7e4NMZjrTOXhoFTnwvLW82AdXEiRcJRt7ufQ3lxHp+7kkSjXWeQ8JD/X9h
         CtdVTPlka8J42EvpyJuK7Y1hYs0wldNEE8Pu/KuHJFp5Bs1P2m7IITAbxw/L6HVuQE
         oQHi6PTsPowOkPNNYXngx4XZHhnVmKtZYy/BryZgENcD3OXg2bgPrRGaOUADZP69OB
         t6mLFKFKwcTA5PORO6vHIwpyk4ft+ky4xTF4WldtzkW+uEho+r5Pi8ziE72LVODodC
         avSMaO3VwbulA==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 2892B7401BF;
        Thu, 12 Oct 2023 08:46:06 +0000 (UTC)
From:   Xueming Feng <kuro@kuroa.me>
To:     cdleonard@gmail.com
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        usama.anjum@collabora.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH RFC] tcp: diag: Also support for FIN_WAIT1 sockets for tcp_abort()
Date:   Thu, 12 Oct 2023 16:46:01 +0800
Message-Id: <20231012084601.63183-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <338ea07266aedd2e416a830ab3fe8f4224d07a30.1656877534.git.cdleonard@gmail.com>
References: <338ea07266aedd2e416a830ab3fe8f4224d07a30.1656877534.git.cdleonard@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QdiDBwQIRD3O2f_fmkj6vNqEYOEkzmC9
X-Proofpoint-ORIG-GUID: QdiDBwQIRD3O2f_fmkj6vNqEYOEkzmC9
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=322 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1030 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310120074
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Aborting tcp connections via ss -K doesn't work in TCP_FIN_WAIT1 state,
> this happens because the SOCK_DEAD flag is set. Fix by ignoring that > flag
> for this special case.
> 
> Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
> 
> ---
>  net/ipv4/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I tested that this fixes the problem but not certain about correctness.
> 
> Support for TCP_TIME_WAIT was added recently but it doesn't fix
> TCP_FIN_WAIT1.
> 
> See: https://lore.kernel.org/netdev/20220627121038.> 226500-1-edumazet@google.com/
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index d9dd998fdb76..215e7d3fed13 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4661,11 +4661,11 @@ int tcp_abort(struct sock *sk, int err)
>  
>  	/* Don't race with BH socket closes such as inet_csk_listen_stop. */
>  	local_bh_disable();
>  	bh_lock_sock(sk);
>  
> -	if (!sock_flag(sk, SOCK_DEAD)) {
> +	if (sk->sk_state == TCP_FIN_WAIT1 || !sock_flag(sk, SOCK_DEAD)) {
>  		sk->sk_err = err;
>  		/* This barrier is coupled with smp_rmb() in tcp_poll() */
>  		smp_wmb();
>  		sk_error_report(sk);
>  		if (tcp_need_reset(sk->sk_state))
> -- 

I recently encountered a problem that is related to this patch. Some of our 
machines have orphaned TCP connections in FIN_WAIT1 state that stuck in 
zero window probing state, because the probes are being acked.

So I decide to kill it with `ss -K` that calls `tcp_abort`, it failed to kill
the socket while reporting success. However, the socket stopped probing and 
stays in FIN_WAIT1 state *forever*, with ss reporting no timer associated with 
the socket.

After some amateurish debugging, I found that because the FIN_WAIT1 socket have
SOCK_DEAD flag set. Thus, `tcp_abort` will not call `tcp_done` but clear both
`sk_write_queue` and `tcp_rtx_queue` in `tcp_write_queue_purge(* sock)`, 
this has caused some problem when the socket is in 'persist' or 'retransmit'.

`tcp_probe_timer()` will check if `sk_write_queue` is not empty and then reset
the timer. Same goes for `tcp_retransmit_timer()`, which will check if 
`tcp_rtx_queue` is not empty and then reset the timer. Clearing those queues
without actually closing the socket caused the timer not being reset and the
socket stuck in FIN_WAIT1 state forever.

I can confirm that this patch will indeed close the socket, but I am also not 
sure about the logical correctness of this patch being a newbie.
