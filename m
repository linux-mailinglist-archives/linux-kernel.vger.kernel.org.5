Return-Path: <linux-kernel+bounces-126994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A589458A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EBC281E3D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB0B53360;
	Mon,  1 Apr 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3hz3vP/"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946502595
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000275; cv=none; b=rzw9/F/jU6+K2GubJhVIcZvZWx6mG0uvpTXTzaI71i4orNFzLRXwzFzm6xPypenFoJdx22LzfsNHTmaqWvtFQgOwgE89MhLWdtRIw8JYcFZmczUTBDN8bh0XiGD+YYg+qMwjwmWmHxwqBYoojZ5Jpkpt5Eugjl3oCp2/qvlcBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000275; c=relaxed/simple;
	bh=xuqHXN4zEeUNZMXx33bJnwKZ0Rm+9CKaKbfpwJF4MZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSluknC3Mz4jIh2jRaTJUhTjbLSAlPKR2hD++0eGZd6fSy81YlRGs4mSKtT0SB73D5TqUM8QJp8c/Fml6xU2vsu16A35OsX77U67sqg0+tKwB9YHJmrms3KkOu0+dEvW/BzgIy9DRPr0FHvMfuyNVjePCqc/P4cjioecskf0gaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w3hz3vP/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so5493838e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712000271; x=1712605071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpZBIepliUIdIDq9qpuFvhCDBoqwn1BkfdsmAhnd4j8=;
        b=w3hz3vP/UBrVIk6gqlQrm4kz30RSvOKyQVNK/YIWiOuJSK19B2mKRrRii2x64VQaEZ
         BKnzfnAPL7d17kfYha0MHB1bRlkDUOIKLta+uttvnwn6zuDWbBSeQORgUbdAQocnATSS
         JJOJDmPMAVXAbWofnrXQ5SB/ZkB0MbqOvDv5XErtfEGmK7/+gypRLwX8oLOBK42zNANB
         FM2YYJJzAGcjjhDOqvIcbRg00pXJZX8QFkgT3fdgxEjHtHGQNXuJUUJZZwRyaMaWlFhk
         wkV+HtzWlORU7b4UgcIk1pMixSufaf7tnec0uQCB66X0Rs5VZMbLJp8c/OsAdAddpQ/v
         8spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000271; x=1712605071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpZBIepliUIdIDq9qpuFvhCDBoqwn1BkfdsmAhnd4j8=;
        b=HcA3Crdpm2EbX67oMD/yPywdAnKwSvAkZJ4pYCIwoiYRKUy9TpFUlX0amCYsNiYCn4
         SBpbndKEALSCkwZT9vtgIYDNI9DhRV4RvN/qKpwmPtuVtl5XVltSpOMcYd2GN6rdrqmd
         bMTt26UgKFKBu9SEfylmicqqodLu2/MgBtK0dVxlspddCT0UqxMa3JIlpzEb2kKZx15A
         cVZObHieD3ZrKAS5F5QiqQ6e8Px+dN/rH/7ylOV6488nKwnRQ0YRNWIDL/S2qWsC1YOO
         1ICcd0AwMVo/3IlBvBp3wwE+2gxAZHYJa38ta8k58xtW/vsRjXEaC97ttCMul5NcfN19
         CY2g==
X-Gm-Message-State: AOJu0YxNRJBkBr02f+qV1SKn7DhPhdWTKFDR1YIEmM4fUeh2k+QrVO0G
	MLes3BpZdJG5xwy+M8LA5K4XwC38SS9/l78t8kLBunfmJp14kfoUSFm0BnJ9NOs/UUFDKeNmTiS
	P
X-Google-Smtp-Source: AGHT+IHAHDdE8MOUf8TBYkFZMj1NtWlwp0g8RhYYEp41IYSn3JjWicOmxmund8OvWk+LyeavvMmDRg==
X-Received: by 2002:ac2:5d71:0:b0:513:c9ca:1333 with SMTP id h17-20020ac25d71000000b00513c9ca1333mr6333619lft.22.1712000271339;
        Mon, 01 Apr 2024 12:37:51 -0700 (PDT)
Received: from eriador.lan (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id q17-20020a0565123a9100b00515d1c97053sm1066373lfu.223.2024.04.01.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:37:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux-kernel@vger.kernel.org,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/display: fix typo
Date: Mon,  1 Apr 2024 22:37:49 +0300
Message-ID: <171200024668.1772895.12933458205220245271.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119102215.201474-1-oleksandr@natalenko.name>
References: <20240119102215.201474-1-oleksandr@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Jan 2024 11:22:15 +0100, Oleksandr Natalenko wrote:
> While studying the code I've bumped into a small typo within the
> kernel-doc for two functions, apparently, due to copy-paste.
> 
> This commit fixes "sizo" word to be "size".
> 
> 

Applied to drm-misc-fixes, thanks!

[1/1] drm/display: fix typo
      commit: fddf09273807bf6e51537823aaae896e05f147f9

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

