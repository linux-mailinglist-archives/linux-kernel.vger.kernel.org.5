Return-Path: <linux-kernel+bounces-48151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEAA845802
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ED51F27833
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAC86657;
	Thu,  1 Feb 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKNaEL62"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8781C86644
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791526; cv=none; b=gaRidR0dY9ENvcHjIVAobJxhWDLcciiYUJuswtyrMkcZcIUeIa7zRzcukA1VqjAz9tYs6PCJbg6TarBjcB6y90YDayQwPpiLynz8Qr5bQjwYqNDvOp674AoUhhnbl17gA5KrXsfgNuMQLEI5C7+Hi0kERzdVJukRiceLx+P/qyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791526; c=relaxed/simple;
	bh=tdOBXoUmAzKU7wLxQfgf5fCWVvxqg5Mp9JZ58GckJSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sID5AiLxBjtcjp01ZLqJxIlT0TmTFMMLYjKY6CgyKuS/ZEhOmTIhwXHKXGeLUWawvTj71B6SW7vKskQe1+HCHCU3FHkcrdZffWm0qz5Q0atejUJi/57Wx00UffdHMe49Q3oun2XyAbzsp7N0NSH/X0WCMUvbRh+gw2f9wp0dbls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKNaEL62; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706791523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=acPDh/wobuUhSXX77WSQvrESvNs+PiaIDyxvT1VTP4c=;
	b=SKNaEL626dksDPOMMmQel5pb6ErQXV1M6MrPXA7j38Vpq9il7GdAjC75SP0P3nvZcDK8d9
	jmugkmwQ4DVvNnrCDmIukFW6zwkVy23NG8C1YgNgcsmvWOxZIDyIRxtyr8J9BXwA/baurE
	3mh0Kqk5X+a+2ck9IYiuZuFj1mSoLZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-SUOZJJBdP3mrrQOP1vIgDg-1; Thu, 01 Feb 2024 07:45:22 -0500
X-MC-Unique: SUOZJJBdP3mrrQOP1vIgDg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4303fceaso1477605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791520; x=1707396320;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acPDh/wobuUhSXX77WSQvrESvNs+PiaIDyxvT1VTP4c=;
        b=FLvLO/idFxBiIu9uXLkvns5L4SVUlojnndkXWfbZuuXAckow1mRpzT4wsUtx6XwGjg
         A7pHSwJUwaACNwq7Yhp59V6BJ8dFbCLjph1hor9bdV9xeXiYmL88t74Hk8TFsFZ3155G
         4DgD83jfHuw3Ve+PzatZl1SfEbU4OGf64SnVybD7Uv+NVbBOa9e0rqsUenSkfQE5PKYJ
         y7t4axEmONbx/Fimb3Oy9syq+EY3yy7XNucLoUf2o+8jqDAr0bh1yzGqmZXZhB435ZGE
         BotSWbanKoxHDF4NxpHNiaS+ZgBua7b9xCJz5oYnlr69Z4cdacUIr5qBBqT8vPlABp2N
         1aQg==
X-Gm-Message-State: AOJu0YzLxyBLDJ+YhdsRY7sojjfq7NlMCtYV3YuLyxJOdagpUNG9cjGX
	mqjL/Nha9hsJ+pz8i/lizfdx6rhff54yt+H8kvwW1bm8czW9SXrOtJyVjh1J813QDrZewthS7mD
	ebsDQm+SWrGHQvSd8+RJqcE07xAd6Y9qoehi4Gck8xgt2/tQBIDZEkj+IF/EOHbNmR01Nw8uj
X-Received: by 2002:a05:6000:1106:b0:33a:fc78:55a2 with SMTP id z6-20020a056000110600b0033afc7855a2mr1830633wrw.0.1706791520618;
        Thu, 01 Feb 2024 04:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjhTK8WPfbdA2cvIjxzj7/UOMM2QJ6/f+BTSl5lnLwBOeDsjdeqEAWpK18vQCBhLpcKpK6oA==
X-Received: by 2002:a05:6000:1106:b0:33a:fc78:55a2 with SMTP id z6-20020a056000110600b0033afc7855a2mr1830605wrw.0.1706791520247;
        Thu, 01 Feb 2024 04:45:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVXIA1J7l80ZK8x6u3KBU3NL2TK5eMSur61/T+3zoMVOF/2+SZcOQ16GXV6jC+Zw9JzSUddKz6UGgYW9ZITSbRk3d/vG6HezYxR2wtP1aAQ7SILnAXkb8dhB/NGcuq32BxcqPOqrxjMh0egFe1XXS0G1TIEo2AGpMXFVz7gjKjrm1seyrtilfR5MPpuWhPtp+Os4gViN+PObg+wmzJZccHHxIduJvVl8qe4ytj1iQSEHBAeFQIgF639fcEhEWl5Kyy6PkKb5OqaU+ZsbIf+aDLZmuXTfNSK1R0OgTpDu5nlAKSGsMxZEwORiRGT3Xkk3g7cmy0ZSpZEOmChVwy/5FaehD2Pcs3Udl07UjfUQShjSYOoCLx+8FuDLd8UkqCjERewdsB4qj3Qu2CRX6CQSblMOChSLT3azWzpAcCvY3C9zXvKroHxGdWXBYjW7s+bGu2kMwg6e9Xyxax/8+pE4fiwZVEQdWwMB+bmZPQmHOtjCyOAy20L1WCFynIqaD2/Zc+CChOzdkiKA0jSNvtOnsuajf8qqCdqNo55UagR/oUh
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d4e8d000000b0033b08b9cd9dsm3184901wru.79.2024.02.01.04.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:45:19 -0800 (PST)
Message-ID: <6fa06fbcc77fadbf87c63df66838fd98c07ff14a.camel@redhat.com>
Subject: Re: [PATCH net-next v3] net: stmmac: dwmac-qcom-ethqos: Add support
 for 2.5G SGMII
From: Paolo Abeni <pabeni@redhat.com>
To: Sneh Shah <quic_snehshah@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 netdev@vger.kernel.org,  linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 01 Feb 2024 13:45:18 +0100
In-Reply-To: <20240130111234.1244-1-quic_snehshah@quicinc.com>
References: <20240130111234.1244-1-quic_snehshah@quicinc.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-30 at 16:42 +0530, Sneh Shah wrote:
> @@ -608,17 +609,38 @@ static int ethqos_configure_sgmii(struct qcom_ethqo=
s *ethqos)
>  {
>  	int val;
> =20
> +	struct platform_device *pdev =3D ethqos->pdev;
> +	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct stmmac_priv *priv =3D netdev_priv(dev);
>  	val =3D readl(ethqos->mac_base + MAC_CTRL_REG);

I'm unsure why checkpatch did not catch the above, but you need to
remove the empty line in-between the local variables declaration and
you must insert an empty line between the last definition and the first
statement.

Please also reorder the variables to respect the reverse x-mas tree
order, something alike:

	struct net_device *dev =3D platform_get_drvdata(ethqos->pdev);
	struct stmmac_priv *priv =3D netdev_priv(dev);
	int val;

	val =3D readl(ethqos->mac_base + MAC_CTRL_REG);

..

Cheers,

Paolo



