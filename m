Return-Path: <linux-kernel+bounces-96024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8787563A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F06281B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692F1E4A2;
	Thu,  7 Mar 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrrVfSOZ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8401332B0;
	Thu,  7 Mar 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836937; cv=none; b=ZwC2yDyL4rcrmVlOzOK32mM1eLKug2hTaJs8NQwgaCof9lxjErdQhso9bLMUKmxyCqtKStGSU+cgS5SG75ur2PnfXtXoy27c5YW+2OAI4f4lLtLrwcyMtTrt64UufapNS6URmaPsnt6BDkJ5/Ze7xu6iBIuQ6gCdEva5dHL6Fsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836937; c=relaxed/simple;
	bh=Vm26hQC6TP0TZ8ALS8GTPK2aJnU7wus96ua4gmFZtLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drya/Lndu7ZVf6/KfJzLR/z6AO32fqi9IntWAV26dU4zMJtRhqeMeZ7c9QxDAttJIPrwSpZibz9kPgPsqM9cvpInBu49UnjRylS4VMBenSHKojPEk/Jf/n0fjXPCqwseRMcgG2fv41QFLRlmZsQaK2u/j2zI1OwBjY4TLz5ZhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrrVfSOZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so973789b3a.0;
        Thu, 07 Mar 2024 10:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709836935; x=1710441735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+X7YJbzUJELDH0qJ30XvUuFL7xCJtb0DCUWLiFQAh+U=;
        b=UrrVfSOZCrW+jTCAEMzlGZXbHKmdDtZmPAoh9up/EhZGTS1/iZoxViauRAErkxrLn3
         bnPvfZojT2S2CDn/4LlavmrjuW1osrwWJaMm7sStrPsKwtYE8LJkxtOfpVyX59SFF4s0
         BednXUQVDwWR8eoFthKUsM6Ivr5cvUDSOMndDm7PqyG0VM9Z6gRbuwU01VCUf3Cz51YB
         IHhA+DWCOLlUWs/gk9QV3/P6IGA/OrcDmtVPyFM7UhiTphGAD0kxajzvfY6hZrt1wmvC
         YLIjmItVNbAOIHGXe1UjTA6/jrNhwePTbl6a4NKo64ySBh/TOSeJXbaIHjzvqEOIaGHh
         DRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709836935; x=1710441735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+X7YJbzUJELDH0qJ30XvUuFL7xCJtb0DCUWLiFQAh+U=;
        b=csdFVAVgS/fjzkHIZK0XP4jCEvYzys+RufpprRjeyQE5SyO9jrbbm6pg0orANuVapR
         4K3JJrRivjhbt7E/BQ0RT/Nf7xDVCOtDJAf92tLCqDx3SZTbjSekkfxgoZlH3w/9yg3S
         skfv1Lfsflz/arYdCUbu/npMb3ggVKrB8SWNxJ0o2YYz6LvGwEfa5vz8PKuH61j6C0Ap
         5alxGVAefdC6Nz3PL/ROBOhsByum/b7l6xEdObiin4opl8MBsuHA/JrZt7xIzKfSIHNI
         e/TwyHrFReYZRMNHc2gXCrilAPvsiQN2MPyplEMRbnVn32ZucHiOp2XWjlS/KWeAuuAq
         S7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVwB0PUk9l3Uu9FJ9r2pt6VmCOlT44DnmHJzI4GIU2H7p5mi6Hkm6pSkRv+NfZRL11aRt6JxtblYWEkH+kDnlRfmsIgVi0PGxyiYkFXlO4KAjJg5lCN5Ch4HBvMN4jH0iNxRah8NqdcQDNQoe3KpxPy5YmKSfDdzDUeCZpQ3l1C0k/ppmvV
X-Gm-Message-State: AOJu0YxXLmwWjf0kerJl+k51uWi4w8M+E3eu7XlEcVEVX9qao1TrcqJZ
	fy9j6ZKA1KNg9tkO/TKbkqU9RR+mEbb2y3HSGf/P05AjNP2+4aeJ
X-Google-Smtp-Source: AGHT+IHjG00KJB3xunPaICQUnoInN/Fum7F739RwIYd8rpmpRCEQTFDPdhIz+aK2/WnBDDeipMkhFQ==
X-Received: by 2002:a05:6a00:90a9:b0:6e5:1196:6cf5 with SMTP id jo41-20020a056a0090a900b006e511966cf5mr3316951pfb.3.1709836935067;
        Thu, 07 Mar 2024 10:42:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a8-20020a63d408000000b005cf5bf78b74sm11482966pgh.17.2024.03.07.10.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:42:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 Mar 2024 10:42:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
Message-ID: <9b5c352e-e36a-4b3a-b523-5dadf8e6348e@roeck-us.net>
References: <20240307113325.3800181-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307113325.3800181-1-naresh.solanki@9elements.com>

On Thu, Mar 07, 2024 at 05:03:24PM +0530, Naresh Solanki wrote:
> tda38640 has a single regulator output along with CAT_FAULT# pin to
> report internal events. Hence add properties for regulator & interrupt.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

