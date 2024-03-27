Return-Path: <linux-kernel+bounces-120395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E788D6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1317529D7E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2076B286BD;
	Wed, 27 Mar 2024 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqhmHbfT"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E25249F9;
	Wed, 27 Mar 2024 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521687; cv=none; b=cjBFLJkhiuEI+1sYGcNjiULBebJZ3hQ0qbWZWlfviFPchSW7lIwNG4X+Qrn4NT3fz7PnjE/PjzsFAq8uxE3p0q9CvlU8al+wh+5wvxV92Pgm+eBgnrDAufdqllCi1l9IKN7qSj1asxbtMPe1vkrLqI6xbSIiIadBTJO3PtlzB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521687; c=relaxed/simple;
	bh=Veuy1m8uxACdlf5PxY31xxr+35oOGhJJBwn68nyJ7qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyZJTwiDrJibGGLajlFlXjIaY6Krr6vKDdwanO9q3HEKZapvizhCAP4OmN/cP34zrg31kTTFzGbupduHf5dPElkRc2nHvOayrPPdI/AVmDPDFQAH7XSH6s9yZiiFocHTzaUetVBrH/29oLxDXBT1uvEufbls94EMuknja+O7F10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqhmHbfT; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a4a2d99598so2922314eaf.2;
        Tue, 26 Mar 2024 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711521685; x=1712126485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Veuy1m8uxACdlf5PxY31xxr+35oOGhJJBwn68nyJ7qQ=;
        b=UqhmHbfTtpFSORuRzSP6vYEtJ33VuxU4aFreq3glSVQg5sl0HOyMceh5USYkrdKcQT
         vRE25UUIqHucp1OmMNX5se9dw/lUfI7sku6vnccLLcUXB5rcUrSxVMPjk/Lr0BcAHb3H
         bdNfTpuwyo3qgwYJS7oCqWoT7YMsVzUGm9kTZoYV69uLwcJji7VkBnq4fxmHFEVjnyi2
         UCRGm/AS8YJ4qn9LB/c7r3Ga9omsdmvZ/RvVJOoZj2DcfEK4dYkaan2YKolYL10Cfuy6
         9eCn4VIIGKUyWLKDRF5O/ggDsFxHfJdeqpDCdE8QeM4q+xWKFECPo/8lGpyK5qussK4p
         Df/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521685; x=1712126485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Veuy1m8uxACdlf5PxY31xxr+35oOGhJJBwn68nyJ7qQ=;
        b=YBAdwDtzdKyJAEO4hTLENuZknfIlTRIn4SN6NNMEjI1II6FOtnHpSZAFwduj0crI5x
         hH7IzuH2VorVqozqRdr/EZQ29aeqexI9vQA4Y33wyY/sI4xsSwn01M/eizjA73DICLVE
         WSoOgesFJKVHk22adIlAtPSjH+7XEvbBPZiEuCPPy8fB/i2DGSy+VUTTQD2Sp6v/faHy
         x92w0HPJkFpdRl8es5q40Unz9sslO1UfDOwvfo6bgzvF5/sl+sk81qHTIEZsKFwE1ZX4
         HbFme5GaTjjkJX1P9yLKd9eF3vM8Vd3GkBWcnfHckH030Y7edgWH+tnzQE8v983EEGA5
         EnPg==
X-Forwarded-Encrypted: i=1; AJvYcCVzzPqc+wBYeA+ms3dFx1Sfvl4cMNieA8jm2JLMKDNzpXi2A9M3NUtEod/IXJneQYbUDzzuz+IDXSd0OkrukHfCmSiOGTtP/HKVmiHP5zz6GbaV+q8c1Yt4A8FCJUSJhYaH9tkd75qYotkrPOVUS4NVeOtpPKj+HgiUBlkx2YQYQUtniw==
X-Gm-Message-State: AOJu0Yy4Iy7RSxds2mSh9LDOeDHqrgRnlPzkh8R9vPJypT/H1/PIkT9C
	yLEaItpP3XV2FqrrVgOMFlCg0HGfTvTO2h7x2Zll9KQ8gJfciw3bXh12LiaIJ0eDK58mnF8XgKe
	NFtCRsKpdeTiFwgq8lGaiTmpr0zI=
X-Google-Smtp-Source: AGHT+IF8vDHk6Q1MwxoTL2+6tFKjhcI/muzpbx+Te0ONd18hgyVPNKFYdO09+0hEVm1IVvQjzt1TR0Sry4UYUnsMeHQ=
X-Received: by 2002:a05:6870:5488:b0:222:d6a:9ae8 with SMTP id
 f8-20020a056870548800b002220d6a9ae8mr1751114oan.35.1711521685119; Tue, 26 Mar
 2024 23:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327054014.36864-1-animeshagarwal28@gmail.com> <171152048362.993925.5771433856261368802.robh@kernel.org>
In-Reply-To: <171152048362.993925.5771433856261368802.robh@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Wed, 27 Mar 2024 12:11:14 +0530
Message-ID: <CAE3Oz82AgokcQWJXJVvxYQZzqUURyv=2h=-uCgX4tbLu6Z2jLA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: ata: ahci-da850: Convert to dtschema
To: Rob Herring <robh@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 11:51=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Sorry about the issue, I am fixing it now.

