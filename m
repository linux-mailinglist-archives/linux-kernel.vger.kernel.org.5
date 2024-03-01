Return-Path: <linux-kernel+bounces-88014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8564786DC2E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110361F21DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81369963;
	Fri,  1 Mar 2024 07:38:48 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D9200C3;
	Fri,  1 Mar 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278728; cv=none; b=Wn1rUloWl30ZCNvUoFByvcclQ56iyMPdtZ9l4Q0iUzX4pgeBfqQir2b+PEeDJX5/w/Lzljy/fsVuEciagtg5pY0WQehgvegVvKip+XTL4v91nlEwH/Z51cMly382Mw+nABq+9M52IY9p8e+vG1I/l85b1wMEReZZi6phQP2yoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278728; c=relaxed/simple;
	bh=F7luTCPx8yDECS9Wdsq9Mpohuv5Jjgxgt11J+nmzDfQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JyKKPb3DNy15IDQfzgAg2PyXh4vyi994998IcPORs6mdGONXrhkGCMUfveXXQI742Iw5lolNJMMGNVnmPCCXqYqGn4L7vZHCk4DzuMLaCX9YE1BEflRFNGAhSOuaRUQKpQObzzsS9IkhFy6mzV3gdVzyZ5rGsB8DQVOjY1xswv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TmKf16jTWz1Q9Z0;
	Fri,  1 Mar 2024 15:36:25 +0800 (CST)
Received: from canpemm500006.china.huawei.com (unknown [7.192.105.130])
	by mail.maildlp.com (Postfix) with ESMTPS id E3030180060;
	Fri,  1 Mar 2024 15:38:42 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 15:38:41 +0800
Subject: Re: [RFC] net: hsr: Provide RedBox support
To: Lukasz Majewski <lukma@denx.de>, Oleksij Rempel <o.rempel@pengutronix.de>
CC: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <Tristram.Ha@microchip.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>, Wojciech
 Drewek <wojciech.drewek@intel.com>, Nikita Zhandarovich
	<n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Kristian Overskeid
	<koverskeid@gmail.com>, Matthieu Baerts <matttbe@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240228150735.3647892-1-lukma@denx.de>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <64ddec9f-42a8-089a-fb4a-a49a2e80337c@huawei.com>
Date: Fri, 1 Mar 2024 15:38:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240228150735.3647892-1-lukma@denx.de>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)

Give opinions only from the code level.

>  
>  void hsr_debugfs_rename(struct net_device *dev)
>  {
> @@ -95,6 +114,19 @@ void hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev)
>  		priv->node_tbl_root = NULL;
>  		return;
>  	}
> +
> +	if (!priv->redbox)
> +		return;
> +
> +	de = debugfs_create_file("proxy_node_table", S_IFREG | 0444,
> +				 priv->node_tbl_root, priv,
> +				 &hsr_proxy_node_table_fops);
> +	if (IS_ERR(de)) {
> +		pr_err("Cannot create hsr proxy node_table file\n");
> +		debugfs_remove(priv->node_tbl_root);
> +		priv->node_tbl_root = NULL;
> +		return;
> +	}
I think we can use "goto label" to reduce duplicate codes for error handling.

>  }
>  
> @@ -296,6 +298,7 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  	struct hsr_priv *hsr = master->hsr;
>  	__u8 type = HSR_TLV_LIFE_CHECK;
>  	struct hsr_sup_payload *hsr_sp;
> +	struct hsr_sup_tlv *hsr_stlv;
>  	struct hsr_sup_tag *hsr_stag;
>  	struct sk_buff *skb;
>  
> @@ -335,6 +338,16 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
>  	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
>  
> +	if (hsr->redbox) {
> +		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
> +		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
> +		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
> +
> +		/* Payload: MacAddressRedBox */
> +		hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
> +		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
> +	}
If hsr->redbox is true, hsr_sp->macaddress_A will be covered. Do ether_addr_copy() twice.
Is it better like this:

hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));

if (hsr->redbox) {
	...
	ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
} else {
	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
}

> +
>  	if (skb_put_padto(skb, ETH_ZLEN)) {
>  		spin_unlock_bh(&hsr->seqnr_lock);
>  		return;

>  
> @@ -448,13 +455,14 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		}
>  
>  		/* Check if frame is to be dropped. Eg. for PRP no forward
> -		 * between ports.
> +		 * between ports, or sending HSR supervision to RedBox.
>  		 */
>  		if (hsr->proto_ops->drop_frame &&
>  		    hsr->proto_ops->drop_frame(frame, port))
>  			continue;
>  
> -		if (port->type != HSR_PT_MASTER)
> +		if (port->type == HSR_PT_SLAVE_A ||
> +		    port->type == HSR_PT_SLAVE_B)

(port->type != HSR_PT_MASTER) is not equivalent to (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B).
port->type may be HSR_PT_INTERLINK or others. Or here is a bugfix? Please check.

>  			skb = hsr->proto_ops->create_tagged_frame(frame, port);
>  		else
>  			skb = hsr->proto_ops->get_untagged_frame(frame, port);
> @@ -469,7 +477,9 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  			hsr_deliver_master(skb, port->dev, frame->node_src);
>  		} else {
>  			if (!hsr_xmit(skb, port, frame))
> -				sent = true;
> +				if (port->type == HSR_PT_SLAVE_A ||
> +				    port->type == HSR_PT_SLAVE_B)
> +					sent = true;
>  		}
>  	}
>  }

If my opinions be accepted, Can you add "Reviewed-by: Ziyang Xuan <william.xuanziyang@huawei.com>" at next version of patch?

