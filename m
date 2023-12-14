Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8518133C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573613AbjLNPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573608AbjLNPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:00:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36BB12D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702566023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWD8flG08948c+kk5diZhSkaE4l4o5OrXgP93+sWFH8=;
        b=DvsAgNQw4RtRf5gws7m4j72rD15EQf0iFQrZ41WBkKMZT5nrsHaUSUtozJwzGBAF8tfUtI
        q6X3QmWOZs8tYSmVIUM1E2TIjLAvmtJl2mwhY4r6gA5ugnN9hhFjIA4Mbsq18S4kkny1jj
        hkM8jo3Hdn1zmdXpQiMXzF0bzU8knic=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-6T4pY_1JPpqQlnz5ZvBO-A-1; Thu, 14 Dec 2023 10:00:20 -0500
X-MC-Unique: 6T4pY_1JPpqQlnz5ZvBO-A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-551dda474aeso124463a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566018; x=1703170818;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWD8flG08948c+kk5diZhSkaE4l4o5OrXgP93+sWFH8=;
        b=adZ917hl8QxFcDGOd3fuei+RQO+YVc3M3t3l8NWOCL8Sny8p2beiZ8qncoZLq6YZPp
         Hrk0oXYO2i/BGpiF7N50uO15C/ahbI55bBbiYslrb2U/62gJmOT4PE0wTKmK8Tok/hbP
         xuGHt4jbK5DjZYeHiCAC/1vebPUoPfNMsKInCk4R+p7/ewU8hFilKqY/YTNVIdHzGmb1
         W02WA5ocKsm2rjAO2ZEw/BBa9qCAofUfE5eBFXfwG8GTzF3igGh1KCGiFcCSDb5biaWx
         m7PefAfad7sXFnP1xc7YAZNy3EHXSzJPzzATFahri6/v3R7CdSSfJyd2H6VAxonJC1lE
         eDpQ==
X-Gm-Message-State: AOJu0Yzm5qPjPWrmgmud80DDT5iL588isViIk+SVOY5iWm7WKoMEOW4H
        KmNSCS8dMs/hdn7ab3h64VrXg5R1/8ImoBFJPh8L6z6kM8icbWaoCarnSVPCJ1xzEsThQuulcKO
        1/bn1P7UiNFkeeePwUVOfs5CY
X-Received: by 2002:a50:c349:0:b0:552:8299:65fc with SMTP id q9-20020a50c349000000b00552829965fcmr853878edb.4.1702566018700;
        Thu, 14 Dec 2023 07:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEObJZISOhVTutkg5qzmkvSZBjnemH0WpgDmhPCj1LJegEvnc1zWHUUA1QXUujGyd6isycDyg==
X-Received: by 2002:a50:c349:0:b0:552:8299:65fc with SMTP id q9-20020a50c349000000b00552829965fcmr853840edb.4.1702566018356;
        Thu, 14 Dec 2023 07:00:18 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id cn10-20020a0564020caa00b0054ca2619c1bsm6867552edb.9.2023.12.14.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:00:17 -0800 (PST)
Message-ID: <fa171d50e1a20019b4b2bf302043278909b9072f.camel@redhat.com>
Subject: Re: [PATCH net-next v6 3/3] net: stmmac: Add driver support for
 DWMAC5 common safety IRQ
From:   Paolo Abeni <pabeni@redhat.com>
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Rob Herring <robh@kernel.org>
Cc:     kernel@quicinc.com
Date:   Thu, 14 Dec 2023 16:00:15 +0100
In-Reply-To: <20231212115841.3800241-4-quic_jsuraj@quicinc.com>
References: <20231212115841.3800241-1-quic_jsuraj@quicinc.com>
         <20231212115841.3800241-4-quic_jsuraj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-12 at 17:28 +0530, Suraj Jaiswal wrote:
> @@ -3759,6 +3763,7 @@ static int stmmac_request_irq_single(struct net_dev=
ice *dev)
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
>  	enum request_irq_err irq_err;
>  	int ret;
> +	char *int_name;

I'm sorry to nit-pick, but please respect the reverse x-mas tree above,

Otherwise LGTM!

Cheers,

Paolo


