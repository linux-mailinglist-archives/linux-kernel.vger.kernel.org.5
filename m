Return-Path: <linux-kernel+bounces-136682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2889D70C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A3D1F24087
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA480629;
	Tue,  9 Apr 2024 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpt0WKHD"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041336FE35;
	Tue,  9 Apr 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658774; cv=none; b=MOOocn6Xy3tiryWusXLcb98g3VfHkzd11eUFRNK2FxG2OHEV9T9/kjCHqroVEjD0lBCkMcmODDXXPcYIX7DQoGs8+rnyhNDvrAQh7Vj+xF69FnLmftXSI4ZAvLESDXUAO2RdOQAU18hr7/DmkjMdBgcytTXei9Js/1oSKQ5skYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658774; c=relaxed/simple;
	bh=IfKFDBLlzi9VPnikm5bTXrOl3CHU8r8CdsogC4TOvLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjzCyKG/EsAVQjyai3UL3jIiyKBZ7X/ENEZvmsYOgJ8Em50guXj32TnYF/reVG+kBK/lacpeebABhaWqkoFUCHVg88j8a/VJNsEhfdNv72BU5/ZhncxtMYZK28JE+cpv1Ei4SFruDAjK/0L2k5Hma6V9yHHO6AnyNU9n4fsxn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpt0WKHD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29e0229d6b5so4435084a91.3;
        Tue, 09 Apr 2024 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712658772; x=1713263572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfKFDBLlzi9VPnikm5bTXrOl3CHU8r8CdsogC4TOvLA=;
        b=mpt0WKHDdttT7jKpR2q+RtpQVlbhvGpY1FwAp/+ostq9aOexfHzg5mmthCmYEOgjgu
         CZQ6cHQOvLKVIXaCGPThCeE+i2rpGqj8th+aawesxxs7VdX3+WOArzhXqTbDoa9Xdhjl
         KbT19AaPyUw2rJAWOLIs/i3FxGTmFZ1O5RnxfFyZE7ptHa2XFlgR1XnDXbvnTBYAu4OJ
         Nu3CtCRUIcQ707fjFqHwLD39chmOsPpOwaLnC1DDnQnIt6KItK6XjvGOmqs8xJsC4vTy
         k5IjHG8aNalRLWkYQNUtaC/vu+6G6me1qMYsXeVDTFXw2GFRJx6Gi+G8uZTMtN+q/ICm
         wpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712658772; x=1713263572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfKFDBLlzi9VPnikm5bTXrOl3CHU8r8CdsogC4TOvLA=;
        b=pKJ4XXEgm/sZU/ED/NG1T7lYui8KhLFpaE0p44IxdqbmDKcxn1o1DpV2Umy2gRkdHl
         MITU2BrDGdR99AaV8BIp9p5EykQzlbDADecUreOZhKkIumZQFl+OjWNhKKaEv91Q9n+C
         ii59EzkOCghhjmURJ80qEN666VPJH908RIHc2iO7uzW6Ok4r5E0O53oxG/7+U6p6Toxw
         zdHMmd0vl9k+t29vmMefNYonpuza1sbFreHNi1WyQEknrH2Sx0FdHmd+oEegJzLBym1Y
         9i9Jgkj8676fDJxxOf3BdgUtJa/2tEkBeLQylkmGjnueEavehSLdGw6MvAiTdOqa2m8h
         F/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxXdnEYHWtitT9Pfa6vqugZOdNgk9IJJ9vT5QervbChYQVMNPOBNprsUAS8Nw6UfzTCUt2Mg5BddtbmUJN0SiInaOudAVQOAP2MZC3lhxUE8Mp0TLGzJYSzWwd/WjkVBEBUL20mUAsUw==
X-Gm-Message-State: AOJu0YxGR+G4D3KrPWiQcsrT3Hh5mP2IxC73qZXxo5PJEDVHIYbhwb2Z
	UIG6Fd5ONkh0/UZKCcYolldjefUOWbqnq8FBFNASZM1Wg+uuuhp9
X-Google-Smtp-Source: AGHT+IFquuwc8TpE2J4AXzmuDJ/293GQ1bZRzsZtYME1+K8tbEzMq456Hq3Ygvoa4KWXJJ7e96ErWA==
X-Received: by 2002:a17:90a:ac0e:b0:2a4:d43d:1617 with SMTP id o14-20020a17090aac0e00b002a4d43d1617mr6609927pjq.37.1712658772217;
        Tue, 09 Apr 2024 03:32:52 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id ge22-20020a17090b0e1600b002a574ab7f5esm956337pjb.53.2024.04.09.03.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:32:51 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: liujianfeng1994@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH] arm64: dts: rockchip: remove startup-delay-us from vcc3v3_pcie2x1l0 on rock-5b
Date: Tue,  9 Apr 2024 18:32:44 +0800
Message-Id: <20240409103244.47813-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401081302.942742-1-liujianfeng1994@gmail.com>
References: <20240401081302.942742-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After removing this property I still meet the wifi card missing issue
today. So this fix doesn't hit the root cause. But this property from
rockchip's sdk kernel will definitely make the situation worse.

Jianfeng

