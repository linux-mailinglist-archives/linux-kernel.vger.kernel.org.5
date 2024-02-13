Return-Path: <linux-kernel+bounces-64557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB9854043
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E4B7B26992
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CFC6341C;
	Tue, 13 Feb 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="heaiVvIL"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540F633F0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867736; cv=none; b=L+0BSySGymmX2yZqRYpu/BKtW8wa1BBv2/RHQt8vRsNBMgT/YGqlrtujsUI6+jlC3H2WE+Xr3bpl02wWY8ggFfeq0Mv4OUkXgiWMIxvcXqsLk3necFsnYkFII8yiw4/dkYPy7Q9SfbrgGaDPyr6mNYgjVUPeziY2YwowFBbPe1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867736; c=relaxed/simple;
	bh=JaLcS0MhnhYo6HqFOcWGWSj+KGWfIIInyL0CMdYPrLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaRGE4ljqPwMcoECiSASIWd5OP4VomotWPKuu/PldY4gXSYVcskgM7u+EqyX8jXM4fq7RdtCu+dFYYi2gjulZ1N5XEvtRL0Vc1SNEV3n1WRTv0PvNzMjqJoUs+1aDoRff0U9a4xqa8OxmwbmHzyfMQawUxUHhGHrG0D/mcrNbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=heaiVvIL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so3575215a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707867734; x=1708472534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=in33zmkUwO/lJCZx5ql5VPHI+fJoeC5L2QBdGV5S4os=;
        b=heaiVvIL7p1+JZGvP0iOwvDgcGu/fxW7meOB/pjLgJAoF0/QXH7oF21t33SY3q3pXJ
         yDnjXvn3Gt8+Ea1HD1xmZGB94kGDzp0lMya85g8nqhjiqlbt+jJw+mVdt6g62zDTpo1n
         ctP5yc/UOPXm/VYSB5cDnwNnwy/D8FhB3u2aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867734; x=1708472534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=in33zmkUwO/lJCZx5ql5VPHI+fJoeC5L2QBdGV5S4os=;
        b=HrrAD+zLOax5p6wHaJ3P2pDGrFYmSVYNcWTtzcDJl/FQhzWs0o/BFwx4No/kE/zmDd
         kKyIhtGmTcqvPAIVJzHW+ASMKk2FIPNeix7CcqBewOjwOeUkOORS48jbbHxPE2gxZJrR
         ZqKviJDJxyMBbXeoNZaVqTdrw8DX9y2LcEP/pX8H0UlcHHAcGemEEY0X8/Fn/qFu4byQ
         DOEy8sRPIaZQE6qrLd6lBfijJPquuTKLGLiVypn3ALd/tcUuDW9XHAlECQnylVRBia0w
         gyqGKbId9a7NOxYkIwit/j/tp+8MiRr15WRtVDC3cPt6W3yxx65HmgjeKCx13Ti4+tjt
         bg6g==
X-Forwarded-Encrypted: i=1; AJvYcCXOJQqCRqRU345KPkacLRIbuBotKJKqSNIIlA3hWXw6nIFwSqTljM3bYmc9ME5oWdLYuu44qxSYF4xwItXAvz7Akk0hVIqS+wsaL2cW
X-Gm-Message-State: AOJu0YyGr22gU6rV/PVl4EH95UQcEMRysEIcMdQTigJG5B8Q9KzvEDfa
	DsNvRqCuWmOSzF4G5Lo118H4AAfM8UjzM7lCYUuKs05tWIidbsioptWiALVoNg==
X-Google-Smtp-Source: AGHT+IGSYalst2dKtHcY/eT+/mlGz5OigXUcaMLj6UjOLYc366SR0E5iVkAW+fP8lCyt4hbxMhmC3g==
X-Received: by 2002:a17:90b:205:b0:296:892b:4c0 with SMTP id fy5-20020a17090b020500b00296892b04c0mr963267pjb.41.1707867734152;
        Tue, 13 Feb 2024 15:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlVHC1f//hzKVyajZIa/bmyDWH5OQtGUzqsr7wgHc7Wl98sibIfjbfMPN1ydIq6ub1TlcIzCDSFA3iXjUdbeDDzsKqqfzpbT+69BWdJ5tIuPQSp667cZav30hy9odQq233bRml1rpMox0+VHwWhXt05zA4AI4b4mpzbY89rm1HAQzAG7Tl6BNMddRAIwzAcx7tYxnjYGb0oI1hdSdFybB5KKyLqVS5zaEeeDKd2n3VxWwJjV1zekHCmDRfBbtO4enBbIYqFxcpcDNFWrZRtxUVV4I6NQJsVgmOpX0kfTFMV+xj7aNsyIxrSuVMcsdGGwYoTO0C3w546gK4aCssnIdxn9DoE1V0CcXvJHpazg+zsgTWAJm5nz8VuzLL6m8SSOZzj0eJAr0iF6APm2jIUn6882qgS5bguwQXCE6rhN3EjAJsny79IHwcHRs2+m+4iUrKnkAhDTXdeBGsrL8JfZktsMjvUTLzG0opYjNjMn1ux70JX2pVBbys+rlXb13/
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090ac29400b00298c06d843fsm84671pjt.3.2024.02.13.15.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:42:13 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] net/ipv4: Annotate imsf_slist_flex with __counted_by(imsf_numsrc)
Date: Tue, 13 Feb 2024 15:42:11 -0800
Message-Id: <20240213234212.3766256-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213234023.it.219-kees@kernel.org>
References: <20240213234023.it.219-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=keescook@chromium.org; h=from:subject; bh=JaLcS0MhnhYo6HqFOcWGWSj+KGWfIIInyL0CMdYPrLw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBly/5T7cTDxgTr0rDIqvT3vhjqivyAqSR9MrmXk vJe8ulo+06JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcv+UwAKCRCJcvTf3G3A JjLOD/9kSRrC1i4wpx5fWHuu7VPgWHXMKYgp17lT1gJYIk6Ae40EuhyRDJZR+MqkiW8msoUquzA cDzdbDz26Z0dJgcnpAmerx78u08EYTTHrYMUaZI00fnzYhfO7GrKKNQ2o4i4C2BOt3IuiO1CbMP zJ4di3CiyGy71ooSKn08Z3/5pTLNAdmig+gl3GP2GNI2U5ny8OHZOOdSXxbaaM5059spgeEdSPF nbU6vXD4q5enmZH3V9CBHGOG/uXxO4okDQDH1y0gKDJu/PQ1foGcmqtqlMoXCMF3bKvq4/eiQ/B dTPsR8alCW97wnaa+pi6F8SlkVC8XmxMghe18rGMMBLVOuh/IS/ypL5K0b5TCPKZ7leqWFiRUEZ Vd7OLDIFl2GbI84vzx4s7kbcM9rhX7ADl46J55D0+xFomlstdpJSJapDvEonhrYUda4b18+paY/ 6a9OxcX4ihmoNr83RlW/n9RXCNtBVQin+GylpP5LQvS07iQ8GCZhy1qr4Uajq1qaffdIDYwSS/M FMytHRtpsPJCOMq7evN65jd5bn82KKnoKnoIx/M/IyePgJy3gKPL6+lVP4YU5db/OgXrvDxuFM3 Bf1sZ826NZDOgvVq2QlC3wP9X3CDLTVHF4Ab4de9u15ky7gTRZMgYZ8CpdLqudDhJ3PyovS9e5S StLpaZfKQmBlPeg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The size of the imsf_slist_flex member is determined by imsf_numsrc, so
annotate it as such.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/in.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index e682ab628dfa..2f0c4d40bc7b 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -199,7 +199,8 @@ struct ip_msfilter {
 	__u32		imsf_numsrc;
 	union {
 		__be32		imsf_slist[1];
-		__DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex);
+		__DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex,
+				     __counted_by(imsf_numsrc));
 	};
 };
 
-- 
2.34.1


