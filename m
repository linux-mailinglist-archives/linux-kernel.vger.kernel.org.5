Return-Path: <linux-kernel+bounces-131300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA48985E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12B1285346
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BADC823AC;
	Thu,  4 Apr 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haXZwBT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F3F7580B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229493; cv=none; b=WF6EwTWz74LNGjyYoGNIlVFD9gAKc/zQA2bug2B5g4Dyr71ILhWIUFpNr123ahdI9ddLiwqKS5XzxHthTa/HlGIDlA8H2JWXRalb9r+0BnRGs8D3ThuLsSiIcUWob7aHz8qj9ZjBjp4TjUm5rYfSDpT9Qd/kvo1Xj4F92cAe/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229493; c=relaxed/simple;
	bh=pqVEUMf7HppaoHOf5QBIOGA20MRtzD7dUEbbywEwkdk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PFPnel4NzzR7+n+2+CVIo5xGlWk0JIXQctpkd28enXrciSTgD7mUlxiTkdlu5NduXdb0AW+/X16yVb8Fom0ZQM0XOw36YEHfzNBemAAjMyzV2KvMwZmsGzTPy1R5GVU+yXqGQi1k/UGi+2i3xmpJ1AQpxoHPgo52EjP4Tr92hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haXZwBT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD3C43390;
	Thu,  4 Apr 2024 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712229493;
	bh=pqVEUMf7HppaoHOf5QBIOGA20MRtzD7dUEbbywEwkdk=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=haXZwBT6RROgX8D8TBAE6J0J3X6V5/uUevMrtxPWRBLLrIsTNrcl+6xJMkIuXM6zw
	 5pPTCWLb4wBskY+xXgaJ+7yC6gGoxo+jWzSFLcJ0EJdieRNHWBSTfJH9ps406tjxfL
	 p4uoTSGDUyI4QrliG2JkT4EitX4FIkRvYFNRqznEM9b2R7VKcZ7eOmhN+mlk+N8qYv
	 0Ix53vGga/XY6lpwWbafDKrhGpay+8jBkVew7efHr0cf6qffVYoVAc/AWnyWf0RFRX
	 IW6rSEuWJdva7mgaIaw/BBhfZ5QczygSgesykZAF/XA84WWg4jYDhSWddXO/ffg8wr
	 frAjxoydlg6AA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B3E501200066;
	Thu,  4 Apr 2024 07:18:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 07:18:11 -0400
X-ME-Sender: <xms:c4wOZq94GTh8cK2nj3NiyiN2VuNN7BE8UMrEASRsSs1cykOR5kRTYA>
    <xme:c4wOZqu4jxBfqt3PmfzH25ogkf3oji0zmTIV8R3cK-JHYI48U09YV-kxZjrTGV-h0
    0q4sWNKLaDMp_Sjskg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:c4wOZgCbH6xkSyaQb7AuIuq0khFldeWzXLrNX8Pxzg6KUm3xRyps4A>
    <xmx:c4wOZidrmtcAoR60IMrrcd1Im2aANYt2Tdl_FDJ95GzSJLG1_b9sJQ>
    <xmx:c4wOZvNtPF_iU2-nNXjNqDmv-foaKP6vRNdLAOqCv1qKmRNRsGGiOg>
    <xmx:c4wOZsm-bW6XkOd7RAhR2Ar1__vTBFivHQHk4cqYVQKryTzknZckmg>
    <xmx:c4wOZorUWbUsqU1QdpHaN0OLZBDa153mX1SjtVoHa6G3dT0MufhqPBg1>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6B310B6008F; Thu,  4 Apr 2024 07:18:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <95a63afe-ccd7-4551-86af-00b7fb0d8ff9@app.fastmail.com>
In-Reply-To: <20240404105840.3396821-2-schnelle@linux.ibm.com>
References: <20240404105840.3396821-1-schnelle@linux.ibm.com>
 <20240404105840.3396821-2-schnelle@linux.ibm.com>
Date: Thu, 04 Apr 2024 13:17:51 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] char: tpm: handle HAS_IOPORT dependencies
Content-Type: text/plain

On Thu, Apr 4, 2024, at 12:58, Niklas Schnelle wrote:
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 9c924a1440a9..99c6e565ec8d 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -26,7 +26,9 @@
>  #define	TPM_MAX_TRIES		5000
>  #define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1
> 
> +#ifdef CONFIG_HAS_IOPORT
>  #define TPM_INF_IO_PORT		0x0
> +#endif
>  #define TPM_INF_IO_MEM		0x1

I think hiding this definition in this version of a patch
results in a build failure because of the assignment that
you are not stubbing out:

        /* read IO-ports through PnP */
        if (pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) &&
            !(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
                tpm_dev.iotype = TPM_INF_IO_PORT;

I don't know what changed since the earlier versions I tested,
or if I just missed it, but I think you either have to remove
the #ifdef above or add another one in tpm_inf_pnp_probe().

    Arnd

