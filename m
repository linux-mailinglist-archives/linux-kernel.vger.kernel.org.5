Return-Path: <linux-kernel+bounces-48953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C866B846388
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E0529139F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8640BF0;
	Thu,  1 Feb 2024 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cZtwKE0v"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80B1D681
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827248; cv=none; b=EkIqcGuy3Qv/DBJGtjXFOiZsAaHGVQs+A3y6rNA82DYyWTYx1zb7FaD2wVtcn1OIun6OybwdaPNzCdLl/UpAhD3CF/UlO+inBGfM9E/fxJ4FXf8FG8M50UcYVDLdvaoNSJn53vCsHp2go+XwGAMoLKpCOVc91B5L9Qq9fQSYofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827248; c=relaxed/simple;
	bh=iejQ2s1sPMan1oL9pie6sIQtQRBGvoNAYklAHKOFG4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNQPXyWipbsdAg6XdY0qTCysJ33x2owVAYgw/jMky1nH9E1gGmQWRF3n3cNcUD8Nn3mzqaOcsXaLXJaIVnnxZkNGTgfIiZd3EHwHMqitHpmi3Vvq1FIKXrL7nJoOC5nRVkE5WluDIYs5ErJx4W8Nwp9T5EnMRObV6vFZSUsJOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cZtwKE0v; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-290c5c705d5so302843a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706827246; x=1707432046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iejQ2s1sPMan1oL9pie6sIQtQRBGvoNAYklAHKOFG4A=;
        b=cZtwKE0v94Jq8mjINJKH86vnrKSXl8whAl83NZNDlVtbS3H7qeSph8zq8uCrb6Y53/
         LXCj5bPTXZXrDYTnygk7uWiqZ1jYxGgPvi4qdDc6leIigHWs6iANKpLvd85WlBiAiI3/
         AHZiuI7MGLb/65dhCD6D4CzQccXGtz4+JTPgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706827246; x=1707432046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iejQ2s1sPMan1oL9pie6sIQtQRBGvoNAYklAHKOFG4A=;
        b=Ll21WShkiQtfWr23uFm4Sel9AESS5hUaNHk95atCOaB2j1fHJYgwQ0bA00oZEiJWjd
         nbVrITMEeYcT8R2g8LHxdpheSXkyQ2apthTSKqG1y1sjoKrn+rA3U8Q1qa/EkLfpM8La
         RWHYJewMtHYUUwC6YaIDp/6HiLHKxcOLN6Ax/ikaY8HbFAZPxcK1WjDygVPPnwsMLywv
         E99A1bi4TMGqrXMYYTNMa2LiTrDj8AEnv2EvRPZZc/NA6q4gYBT44zIRzO4/HaTLSRGH
         qJ+hygEQ0ym5pWPbYRRD8dqgoDRHX+V9hUyUg8D8Aj1pbFuUA41pYm5dCgKavYfbN2FT
         CiBA==
X-Gm-Message-State: AOJu0YyxJWOj0gd8327djy9k7Ysuthv4RCYY/Q1KuDPbs0LkoQJ1/TAE
	X6Ly2LuMl+8SHtqLV7vpw09fo/GRonLneMf8vwvuZAiVKAOOPyECeq+Ec7PYcYoO55CysbEtNyG
	XrmqdBrPtHSQQImFZlx05deZczpqhdwaset/Y
X-Google-Smtp-Source: AGHT+IFNMKKix5nQc1KUt9iO4iwkKRVCR+uQ5KLJ+45eMRcwooPPC5JkcbcdpR9kh9V6hv4cQBNGjL09OHMNvIAJhoA=
X-Received: by 2002:a17:90b:4c84:b0:296:37f1:4e26 with SMTP id
 my4-20020a17090b4c8400b0029637f14e26mr668388pjb.0.1706827246359; Thu, 01 Feb
 2024 14:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119215231.758844-1-mmayer@broadcom.com> <20240119215231.758844-5-mmayer@broadcom.com>
 <bc20da6e-bf97-415b-ba78-ae29311ae38f@linaro.org>
In-Reply-To: <bc20da6e-bf97-415b-ba78-ae29311ae38f@linaro.org>
From: Markus Mayer <mmayer@broadcom.com>
Date: Thu, 1 Feb 2024 14:40:35 -0800
Message-ID: <CAGt4E5uE1Ms8vJbw2tE7fgcxeE9=vPYsa8y2FsJtQt-7jrjE_Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] memory: brcmstb_dpfe: introduce version-specific
 compatible strings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, 
	Device Tree Mailing List <devicetree@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 13:28, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/01/2024 22:52, Markus Mayer wrote:
> > Introduce compatible strings brcm,dpfe-cpu-v1 through brcm,dpfe-cpu-v3
> > to the Broadcom DPFE driver.
>
> Nothing improved here. I think my last comment was pretty clear what I
> expect.

You are correct. Nothing changed here. I did not get the impression
that you were asking for changes to the actual driver code.

As I said in my response to the previous patch, I am trying my best to
work with maintainers and other community members providing feedback.

Please explain in further detail what you are looking for. Maybe this
will already happen in conjunction with patch 3/5. Your responses
there may already answer my question here. I guess we'll find out.

Regards,
-Markus

> Best regards,
> Krzysztof

