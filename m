Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7680E825
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346102AbjLLJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjLLJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:49:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85036E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702374600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nx5UmyccL5qoqkD5GIYjmeEI1AoOZRNTYVJbctvoM4U=;
        b=dsDcJVY51rRXDEJG2BWmmszFsI4lUo/Yts/O7gjNNRHAJwZST1qN0UcPI611JYjt6JcXjQ
        MY6KXqdkEe1tGH7+8imsxuvV/E4AmTtzyX3MjfGgAomBk0zMC4kyOxbWEAeFkJirAVmafy
        RIK4pp/EdQxMQfl7OMwRjtJq2qOPOxY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-5xHYwkX8PaOB8yR82R_buA-1; Tue, 12 Dec 2023 04:49:59 -0500
X-MC-Unique: 5xHYwkX8PaOB8yR82R_buA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1d3a7dbb81so89274066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374598; x=1702979398;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nx5UmyccL5qoqkD5GIYjmeEI1AoOZRNTYVJbctvoM4U=;
        b=FCV0PJ31k23aMnt+Zsh/ZsergdN4MlIPIneEdm2MzsXsjNRlst/Q4AHoykGjJUHCtK
         DYYVdJBbrmsS0wDDQ5uKynsPRl+50k2bei+B3kY0tF9dklr7BazT7vvWUxMbugJgrmVl
         35D2ZC/jZyMA6FEwlkoHqIBbnc7+bdq5NveJFxQv2o7xmYMDE2kp3GTaKR+UOJ2XdYoz
         Tlnh57BePFKzRiwaqG6B2DOOunH6eNcCnbX3pRql7QCH7yGQOhe9AFK6dPFDL3L0ARYU
         zRkGqqy/jwoALicgKZjvUdiahxYMQZ7sCa6pVp7hhL7cBg0/bKfF2FVNXd22O6wg/5+Y
         UrlA==
X-Gm-Message-State: AOJu0YxmBplx+y/QW3PHB1BHdRtR1mrz+rB2ZRyTF5JC2eB8RtO4v3Xg
        Bp0mNMqJQRQC2TBrwoVvi50sZTaHuk5BoFCyQCLfeKdHT6jgQLuiwF135+noRB4eBxTXVupJHb5
        kQz8ubzdfweGDWBpB7Ff3P6B7gYBY0Vyp
X-Received: by 2002:a17:907:d30a:b0:a19:2ca9:8e4d with SMTP id vg10-20020a170907d30a00b00a192ca98e4dmr5808089ejc.2.1702374597854;
        Tue, 12 Dec 2023 01:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+a2VtUqRmkY0FPQwR91HDhj4RPpZbLrBVrcXemjcNy252HiB1DzY8bcZvAqz+J1OPolDA+g==
X-Received: by 2002:a17:907:d30a:b0:a19:2ca9:8e4d with SMTP id vg10-20020a170907d30a00b00a192ca98e4dmr5808073ejc.2.1702374597524;
        Tue, 12 Dec 2023 01:49:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm6059310ejc.130.2023.12.12.01.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:49:57 -0800 (PST)
Message-ID: <a18c5b93b9732575048c551268a92935db4dbf48.camel@redhat.com>
Subject: Re: [PATCH net-next v14 02/13] rtase: Implement the .ndo_open
 function
From:   Paolo Abeni <pabeni@redhat.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com
Date:   Tue, 12 Dec 2023 10:49:55 +0100
In-Reply-To: <20231208094733.1671296-3-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
         <20231208094733.1671296-3-justinlai0215@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 17:47 +0800, Justin Lai wrote:
> +static int rtase_open(struct net_device *dev)
> +{
> +	struct rtase_private *tp =3D netdev_priv(dev);
> +	struct rtase_int_vector *ivec =3D &tp->int_vector[0];
> +	const struct pci_dev *pdev =3D tp->pdev;
> +	int ret;
> +	u16 i;
> +
> +	rtase_set_rxbufsize(tp);
> +
> +	ret =3D rtase_alloc_desc(tp);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	ret =3D rtase_init_ring(dev);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	rtase_hw_config(dev);
> +
> +	if (tp->sw_flag & SWF_MSIX_ENABLED) {
> +		ret =3D request_irq(ivec->irq, rtase_interrupt, 0,
> +				  dev->name, ivec);
> +
> +		/* request other interrupts to handle multiqueue */
> +		for (i =3D 1; i < tp->int_nums; i++) {
> +			if (ret)
> +				continue;
> +
> +			ivec =3D &tp->int_vector[i];
> +			if (ivec->status !=3D 1)
> +				continue;
> +
> +			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i", tp->dev->name, i=
);
> +			ret =3D request_irq(ivec->irq, rtase_q_interrupt, 0,
> +					  ivec->name, ivec);

It looks like that if the above request_irq fails you will never free=20
tp->int_vector[0].irq (and all tp->int_vector[j].irq, for j < i)


Cheers,

Paolo

