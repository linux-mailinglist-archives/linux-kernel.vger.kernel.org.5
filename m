Return-Path: <linux-kernel+bounces-83793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26999869E85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19371F27946
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51421468F4;
	Tue, 27 Feb 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qgxzm8eT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A6137C21
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056944; cv=none; b=WdJWOqyPIaKe/2A/E8Whmxp2UmN2nng7sweuLEM1zwswaA7ebuCc8MGUUXUiPJLvbfnFGz24CLMooL64kRLhFUhJKqnjhF0lSc2CjgMq1tnzOZhkGyqgbA1FF94c4jKZYDfjaBaGXslmA/7JIXcRMcCyQ/MmSLg+i6c7fCVwtM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056944; c=relaxed/simple;
	bh=9srZA86tRQ0Lc6f+G5Z/wjNPWsbOftV358BYgV3yd4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4WTT/id6vge8Tz1hhV9Itk4ZD2faAQrJj7P2wE5oJq96WMh0YadZTus26FaimGfcJ/mWTEKJgYgjfn7NLurX+bjafxJF974A8NtfvwQ0DPImR7y2WqpWfLo6he1t+bWFpJ0stvyj84w3K0vg5DFQjkukAKbrLPFgpzoiB6Jocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qgxzm8eT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709056941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxNc/aFVnNDKr6nzABJwfQofcGO3o2pWudIkQ0RdBpM=;
	b=Qgxzm8eTbqbiBfcHN74hOMw5zgVhAbDGRzfifj84WtSPm4JEFwedN6hfaP2D6ET6Rx17/L
	FMCFTUcgq7cMwBJ7drH/GA3kRuVey5u9eox0zQUomzVYwoaIkGJO2+juEVCXvYjXufdM/G
	xoGS5ziZr6QGznShF/Fc6RgTpr7+qJc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-CtbRc6R1MnGXnmM2P36Yfw-1; Tue, 27 Feb 2024 13:02:17 -0500
X-MC-Unique: CtbRc6R1MnGXnmM2P36Yfw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42e7b88bfa5so24836451cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056937; x=1709661737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxNc/aFVnNDKr6nzABJwfQofcGO3o2pWudIkQ0RdBpM=;
        b=DiH3hMjQScBD3a1pW/v3BYXaZjFGv+l/7XQ+J2zcKD57FrSnzxHAyKsV7HN0AibKrA
         YuwwBN3+/LGRVT8cBkNVrSMYmi38i1GBqt9Vlnxu5IQlA71XrfsNaKbqCGunvLpSzENY
         HjPCsH6wfpjAzyndN8nAIgQrrJEQ7W/e6gUhuIglUU1CHrKJHIWJd1dA9dggH+VXNv0+
         HKqeVja0h24UMRmQMIx/kF3pon+kaJNvV5xSVDvwaLusRE6K0p6RQbGst1fhsoLXlmJu
         IUYFr1Il/A3X3wbLw2qng7KZEyk2iNSv/vxwwlb588zkMQhkN9VrW3W66ZZLwEkIAh7Q
         EP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3nSHu8KBmadUEonfhIT72HhtqXRGOStjNqzFQy605280t1c0yIfsTaplcuo4zeEDHL0Lui4q7LV/7BeDa8QFzqMKT1T5uQiev/6Yk
X-Gm-Message-State: AOJu0YxUk3ZzmsUo6vw1BnQRSKG7ykuDzurr3vCftbYOXeLREvrR28pc
	S3IngvIE5vwzVCk3RC6rHC/X+IKQt8qGuWiVL6NTFjm4rnGMAVmMaKHFBH+fDwcKdU82lFnx+w9
	fZz3aOA2izEYbYth4C0ylXJO5W5do0bH42Z067jndBnz8g4+nBDNYuvOsswSD1g==
X-Received: by 2002:a05:622a:1a97:b0:42e:a717:cbca with SMTP id s23-20020a05622a1a9700b0042ea717cbcamr802343qtc.41.1709056936764;
        Tue, 27 Feb 2024 10:02:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdFPNupQsoGCNMoyarnVyVV+samDOQcNLB9zEJi7UDBBSyn6KQpoOrEG/VbkkBYeBv36V0Uw==
X-Received: by 2002:a05:622a:1a97:b0:42e:a717:cbca with SMTP id s23-20020a05622a1a9700b0042ea717cbcamr802291qtc.41.1709056936129;
        Tue, 27 Feb 2024 10:02:16 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id f12-20020a05622a1a0c00b0042c7b9abef7sm3766020qtb.96.2024.02.27.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:02:15 -0800 (PST)
Date: Tue, 27 Feb 2024 12:02:13 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Sarosh Hasan <quic_sarohasa@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Prasad Sodagudi <psodagud@quicinc.com>, 
	Rob Herring <robh@kernel.org>, kernel@quicinc.com, Sneh Shah <quic_snehshah@quicinc.com>, 
	Suraj Jaiswal <quic_jsuraj@quicinc.com>
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac-qcom-ethqos: Update link
 clock rate only for RGMII
Message-ID: <3refwt5x2xplibxkne5sae4ybic7inzmfwna4vkhprpf3nyqom@lwng6mkbe3gc>
References: <20240226094226.14276-1-quic_sarohasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094226.14276-1-quic_sarohasa@quicinc.com>

On Mon, Feb 26, 2024 at 03:12:26PM +0530, Sarosh Hasan wrote:
> Updating link clock rate for different speeds is only needed when
> using RGMII, as that mode requires changing clock speed when the link
> speed changes. Let's restrict updating the link clock speed in
> ethqos_update_link_clk() to just RGMII. Other modes such as SGMII
> only need to enable the link clock (which is already done in probe).
> 
> Signed-off-by: Sarosh Hasan <quic_sarohasa@quicinc.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride

> ---
> v2 changelog:
> - Addressed Konrad Dybcio comment on optimizing the patch
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 31631e3f89d0..c182294a6515 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -169,6 +169,9 @@ static void rgmii_dump(void *priv)
>  static void
>  ethqos_update_link_clk(struct qcom_ethqos *ethqos, unsigned int speed)
>  {
> +	if (!phy_interface_mode_is_rgmii(ethqos->phy_mode))
> +		return;
> +
>  	switch (speed) {
>  	case SPEED_1000:
>  		ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
> -- 
> 2.17.1
> 


