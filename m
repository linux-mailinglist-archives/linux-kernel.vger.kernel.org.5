Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDBE7CDB5A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjJRMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjJRMLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:11:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA811B;
        Wed, 18 Oct 2023 05:11:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c1807f3400so79194701fa.1;
        Wed, 18 Oct 2023 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631094; x=1698235894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFlKdMhUoLIy2IW9cwQ/XfH6KYhUiKFlcJwgYomjI5g=;
        b=nFpVYqpoWyeoFxPxuTTE2Pg9iG8paPRPww8sLOwTDqus4F65lKcBIdGP/Ira8XwRAE
         rT19+4Kgzp3VThGbfq5syDOGYlyBTiQpwsFm7S9Faj4OgKgRzgzkRRS7V+NMHCtddZ9E
         vkWmnJL9HojR20FLxytmgYHciGtJk1z9t6TBWR7gyhiLQ3NIYx4JNvWJSmiuaIdpZkT3
         FmhCmvRfwOEebScBc9qXZeJOAmysvSXS4H6AxTOsNGWlRKaIapicbMOgU1FEKmQ7Bu7Z
         54ENh3KjXMwcb3vs3CwUZ1OfJr/LAczh8LjzfEmsRVMvUJxmQNVmaN5gBYzLlYVnuq0g
         tjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631094; x=1698235894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFlKdMhUoLIy2IW9cwQ/XfH6KYhUiKFlcJwgYomjI5g=;
        b=aRVkqLV0n4FO5wz+VG9JLFLGiVtK2aaM7DyQDqrhLXJYoWECqVRDleSrEbp7uN4Uzh
         6uUetxQus1t80s6Z3R3L8yid5yKzYknc9zBBax4p6KosHK8W1CMC/KyvLYlyoGzaWE55
         hkx2DihuQtnxDOnRSn0Go+Qbtb8J7GiCN2rxqAg2VpG9tP42GlIonqmtHjgDpCKy4Yxl
         VthQU8DUNH4SffcEj70B2/ocGb5UjzR2BbUns2OhfYLpQiGi+HTmXg8LZNxEfJRYmYVy
         oWAy3zXCxEbTPUyu26uYs4espiW5IlRkzXtJyBy3GyxS/WHCLxDI2vmlxoyqzA/SyxeZ
         kfdQ==
X-Gm-Message-State: AOJu0YzXghZ//bJt9LYd8StslSxz2k9cR6FVMbszZNylaafryXxbvGw8
        PIzveC+XVeLuhV9h1VErf4s=
X-Google-Smtp-Source: AGHT+IFo6SGaEDPexg5Pr/LHwwPfDM5Htte8a/963oN4wVvOJ136+uMBtl7MzApuiAZxDGnKUxdm9Q==
X-Received: by 2002:a05:651c:4c8:b0:2c5:2357:c6a7 with SMTP id e8-20020a05651c04c800b002c52357c6a7mr2293358lji.17.1697631094007;
        Wed, 18 Oct 2023 05:11:34 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.26])
        by smtp.gmail.com with ESMTPSA id u7-20020a2e9f07000000b002bcd94f9714sm674953ljk.126.2023.10.18.05.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 05:11:33 -0700 (PDT)
Message-ID: <102df7b7-a07a-475a-adb6-ae60453feb63@gmail.com>
Date:   Wed, 18 Oct 2023 15:11:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Send netlink ACK before setting connection in
 auditd_set
Content-Language: en-US, ru-RU
To:     Chris Riches <chris.riches@nutanix.com>, audit@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
References: <CAHC9VhQBV1mcFUmXQs1-VKpAVdaAQ3EiGk-G3ybxfcBkoKGwcw@mail.gmail.com>
 <20231018092351.195715-1-chris.riches@nutanix.com>
From:   Rinat Gadelshin <rgadelsh@gmail.com>
In-Reply-To: <20231018092351.195715-1-chris.riches@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there!

On 18.10.2023 12:23, Chris Riches wrote:
> When auditd_set sets the auditd_conn pointer, audit messages can
> immediately be put on the socket by other kernel threads. If the backlog
> is large or the rate is high, this can immediately fill the socket
> buffer. If the audit daemon requested an ACK for this operation, a full
> socket buffer causes the ACK to get dropped, also setting ENOBUFS on the
> socket.
>
> To avoid this race and ensure ACKs get through, fast-track the ACK in
> this specific case to ensure it is sent before auditd_conn is set.
>
> Signed-off-by: Chris Riches <chris.riches@nutanix.com>
>
> ---
>
>> I'm happier with the bool over the integer type for the @ack variable.
>> I'd suggest updating the patch and posting it again so we can review
>> it in full, but we weren't very far off last time so I think it should
>> be close, if not acceptable on the next revision.
> Here's the latest iteration of the suggested patch. I've done it via git
> send-email so it should apply cleanly.
>
>
>
>   kernel/audit.c | 31 ++++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..20c6981490ad 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -488,15 +488,19 @@ static void auditd_conn_free(struct rcu_head *rcu)
>    * @pid: auditd PID
>    * @portid: auditd netlink portid
>    * @net: auditd network namespace pointer
> + * @skb: the netlink command from the audit daemon
> + * @ack: netlink ack flag, cleared if ack'd here
>    *
>    * Description:
>    * This function will obtain and drop network namespace references as
>    * necessary.  Returns zero on success, negative values on failure.
>    */
> -static int auditd_set(struct pid *pid, u32 portid, struct net *net)
> +static int auditd_set(struct pid *pid, u32 portid, struct net *net,
> +                      struct sk_buff *skb, bool *ack)
>   {
>   	unsigned long flags;
>   	struct auditd_connection *ac_old, *ac_new;
> +	struct nlmsghdr *nlh;
>   
>   	if (!pid || !net)
>   		return -EINVAL;
> @@ -508,6 +512,13 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
>   	ac_new->portid = portid;
>   	ac_new->net = get_net(net);
>   
> +	/* send the ack now to avoid a race with the queue backlog */
> +	if (*ack) {
> +		nlh = nlmsg_hdr(skb);
> +		netlink_ack(skb, nlh, 0, NULL);
> +		*ack = false;
> +	}
> +
>   	spin_lock_irqsave(&auditd_conn_lock, flags);
>   	ac_old = rcu_dereference_protected(auditd_conn,
>   					   lockdep_is_held(&auditd_conn_lock));
> @@ -1201,7 +1212,8 @@ static int audit_replace(struct pid *pid)
>   	return auditd_send_unicast_skb(skb);
>   }
>   
> -static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
> +static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
> +			     bool *ack)
>   {
>   	u32			seq;
>   	void			*data;
> @@ -1294,7 +1306,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   				/* register a new auditd connection */
>   				err = auditd_set(req_pid,
>   						 NETLINK_CB(skb).portid,
> -						 sock_net(NETLINK_CB(skb).sk));
> +						 sock_net(NETLINK_CB(skb).sk),
> +						 skb, ack);
>   				if (audit_enabled != AUDIT_OFF)
>   					audit_log_config_change("audit_pid",
>   								new_pid,
> @@ -1539,9 +1552,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>    * Parse the provided skb and deal with any messages that may be present,
>    * malformed skbs are discarded.
>    */
> -static void audit_receive(struct sk_buff  *skb)
> +static void audit_receive(struct sk_buff *skb)
>   {
>   	struct nlmsghdr *nlh;
> +	bool ack;
Maybe we should initialize 'ack' as 'true' here?
>   	/*
>   	 * len MUST be signed for nlmsg_next to be able to dec it below 0
>   	 * if the nlmsg_len was not aligned
> @@ -1554,9 +1568,12 @@ static void audit_receive(struct sk_buff  *skb)
>   
>   	audit_ctl_lock();
>   	while (nlmsg_ok(nlh, len)) {
> -		err = audit_receive_msg(skb, nlh);
> -		/* if err or if this message says it wants a response */
> -		if (err || (nlh->nlmsg_flags & NLM_F_ACK))
> +		ack = nlh->nlmsg_flags & NLM_F_ACK;
> +		err = audit_receive_msg(skb, nlh, &ack);
> +
> +		/* send an ack if the user asked for one and audit_receive_msg
> +		 * didn't already do it, or if there was an error. */
> +		if (ack || err)
>   			netlink_ack(skb, nlh, err, NULL);
>   
>   		nlh = nlmsg_next(nlh, &len);


Best regards
Rinat

