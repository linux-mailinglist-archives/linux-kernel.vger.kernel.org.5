Return-Path: <linux-kernel+bounces-34488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B1837CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D0228CED3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052815B0F5;
	Tue, 23 Jan 2024 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTDd9vmf"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654715AAC0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969751; cv=none; b=AiR4SRpTIvSIB09TzVtnAeffvn45d1/NNqUazpz+p5X9C1ucMAmJVOev/YvbRQIsmRHIzyAgk/iN4rGD0AK5dtiUIOJRJ0REoFq57QyvGPjnOIiHvS7+9wPUOKjLszLp8Ne1PJYVDOsMrQIw20o1z6ZtmcebFr27OdpQ9y4dlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969751; c=relaxed/simple;
	bh=uRCkCvFsyXVpf/RtG8GCWMvVuyi59RVZ9Ft/3XBajpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unQ4ZL9cfU/2npho6WL0zapkjLlxOCwmmDmLOouG2HdF1MYqYiym57xj3noQe/659+iHBR0dJEn61PjuuMwNqb56OJHKvBOUGljeXZ2RIip69hrdCHdzvDqqnPeOlyaU5LvR0cSbJHnEdXJFEeKLMA9DVZ7dPuEUI/M5WmYRMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HTDd9vmf; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5989d8decbfso2467126eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969749; x=1706574549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbagvK/BQHg13GLlZBGhyNRG5sgL74HVCqkvwUtdz7s=;
        b=HTDd9vmfMxS46oacnYCdJMd1aK63IRP3LlrUUFqEmg03ZV/vGdiTTd7LvPfz8BBW/L
         qr9ZquIFSeKht3Xb4VOrKDkGjfVkrir3csOYYaTazijM+1pWg0U4va6TBbNZoC5aksvs
         g15ZsvMVBstvuzMjdMpI+7xwTdA22rqtWlqQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969749; x=1706574549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbagvK/BQHg13GLlZBGhyNRG5sgL74HVCqkvwUtdz7s=;
        b=BiLhR+h91sQgYpI7S2OtKqrQgvCuN/iKN1zmIIMvbl6+Xm8HGdSuALDyvs1sSaOjTg
         C+m9klNGyVHZF0Rv4hrPwm0C+FChKZS0dwQwxUD4w6WFSKCQwZOdCNy04CDIqTntUgHW
         aQH4TRo7OrT5mrpLbkN6Kl1qApQ1G+LkA6jSAx3f1hqGQeZRf4VoVUVoT5V5+QJrhFll
         yc1tX61uSfnIur4hJHU+9nN7oNAxR72Vyqh8uxNMyWQkyhx/qw/2VcBdR4MFV7H02234
         3qkn2FjiTeyzyyj3eapOSuP05vkHqjg8UsH3t6wP+fPrXIPjceaLIAHiF/cJVIBuhm91
         68Sw==
X-Gm-Message-State: AOJu0Yw+MeC130dhCjsArSzi8O275m3RjGHdRtV9cOVub72AIOp3TnrH
	ZT8yueqn5OuHTHIXKIB3gaMRkBASUrsnhm2LKKUTMhxdMUZqcqyCp3ffhgxsbQ==
X-Google-Smtp-Source: AGHT+IE3YZZUAbSaTl6FBGOnqrae/sTpKUCuHtMEUe62rjmX2GkYQhqBolPrkv+LnabYxlrO3YWYvg==
X-Received: by 2002:a05:6358:916:b0:176:5d73:376f with SMTP id r22-20020a056358091600b001765d73376fmr1694130rwi.48.1705969748687;
        Mon, 22 Jan 2024 16:29:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00218300b006dbd341379dsm4094216pfi.68.2024.01.22.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:53 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 48/82] drm/nouveau/mmu: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:23 -0800
Message-Id: <20240123002814.1396804-48-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=keescook@chromium.org;
 h=from:subject; bh=uRCkCvFsyXVpf/RtG8GCWMvVuyi59RVZ9Ft/3XBajpQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJXxmYjo3BZJuP6sKHQxKb/M3OqOpXccNUZ
 qhhlaPYu4iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 Jh/nD/91bB80GL2rgD2Qu9VZOfFU0YicaQRtXMeoaSbnOb9C6bplAraUcHoNvH0F/nzlJcxXU25
 tdFLoL0nVtuTpAc0QwLgnxaobRa9aNgWmW3DUkrO812C5TjVwlXYjliSrA5pLSd1FCOwfEGcLUB
 OasKeE6baUkZj6ytjNign6jV35ncfvu3y/C2MxtKBkts8n1Zwzi540pe8I5UtlySd6rBQjtelTV
 w6SFBV5r1npI2fEZqGplZzZO7EajApmc7jJz1thGgwOaC77JZl1JuklmvrMC4ret/lDs/ycUAAk
 D8MK5b6uevWOPdEY7obK82UJzkJkmcTaxAOtZlX95h01L7rkYBfeFsMYiZxSkbcDNRIQoWxack0
 kuRc0oFbZDU4aaCtjbvKo6CHFYuBsv1B3qzy/dUdlEfz7Q8x7GSiUp1v2zZMHdUUy9zFSFFvHoE
 kZoHAeuRu/Gh7kJhCX7dMPQXqmh1IyQcF7QoTRKQyay+Kirq8rSRKVyOK6qdr+F/8jCxx92g3nD
 2liBspnno23rcfzBqyJV5XbpEehmcvR0R30g5ubq4aeUy2+NIh26YpvJYBT9PIeuAR6WWh7/jm3
 dRFK6//1Q7sP6hjFLcugQJcs/LAqMyL9p1u+btGAthR59AQsdV1I6mj3Cqxb1SXG6UXNsaiPyRb lV4UD0ZObcOgDAQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index 6ca1a82ccbc1..87c0903be9a7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1291,7 +1291,7 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, u64 addr, u64 size, u64 *pfn)
 
 	if (!page->shift || !IS_ALIGNED(addr, 1ULL << shift) ||
 			    !IS_ALIGNED(size, 1ULL << shift) ||
-	    addr + size < addr || addr + size > vmm->limit) {
+	    add_would_overflow(addr, size) || addr + size > vmm->limit) {
 		VMM_DEBUG(vmm, "paged map %d %d %016llx %016llx\n",
 			  shift, page->shift, addr, size);
 		return -EINVAL;
-- 
2.34.1


