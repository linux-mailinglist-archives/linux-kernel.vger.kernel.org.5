Return-Path: <linux-kernel+bounces-130658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA88897B13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B8F289E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6459156966;
	Wed,  3 Apr 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PQW+IFZ0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18331156868
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181248; cv=none; b=l1jwP8um37NxR0VIW2EFHStDoV/q+uJlGQrKH0RGtz6MAlKKri8KsxgO6vQOmITmvDfEqTDlJQ7NEDcVQN4/uUMDw0KfOfb/nzx8MOzDPC/hhnWGhO/PVZlgq9cXnHZuXMQXoobwwed+gTPYJD8u6uPBhb2HmtDzCFCjpBzJGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181248; c=relaxed/simple;
	bh=iQVFWLJ69AonJ7RrN7NlN9bDUbprCHUU+71zAbs8w88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VMoQT9iFLjNS+XDo94ZNYH++MUfw0tFyWpL0Af0JI/bt3EzGnIC9qr8H/Z27EMrvMBfQzfJIzyM76QoYxP3rjR4l9oYLI8/6P7SPVxIHs8ua0wliS++gxVfSdoM45nUO6abkP3NPNhyjqG1pWmI050y/bnSlHIA9mAtJ/Q3ppHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PQW+IFZ0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so263153b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712181245; x=1712786045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyoDF56le3EvhIDIgPf2lEDUDtLNrgDGJWIz/J9qO5g=;
        b=PQW+IFZ09fblZdzdxMXsNTwJ1d9sQKB6IQY0K7DEgdcgNwcnESw/cZeSPp9urjz/3L
         hT6dN1tQJ580PILYblLxRS19UGTTev0J2IAIWqYECfq6zSskempfBRBVTKnDZmRj+SMz
         ZwZPywybjChY9kdPpqJktYVgEApilSG2cq6wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712181245; x=1712786045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyoDF56le3EvhIDIgPf2lEDUDtLNrgDGJWIz/J9qO5g=;
        b=vXEXphGDZXGkFeWc+hkjCyt8ZXAeQj6u2d4Hzd5A3a70M0ZHXj5GBPkSJPwh0q6AUH
         XenPPFIRT1RdO0ieb9lPU2ARNyORJQTThE8IiZQ5vXry4dmCPv+pyON2uprOQrBAZntT
         zlfSvzQrKZwBG5WjsdZku0serFrAs+awsRYhd8im21gRoJuIbArDIgIeEmS9D2SpG9+u
         x9MbHa8P0DzXeo271Q7PblemuU/tg50ypseAgGx3U61JX3T48EXGcBoNeMEbK14AoURh
         0y7T2Y0sp6FR40omY41lY95UYeLzf9E3gc6FjaSVBARVR8h961TlGvHb8MMyJ1XBxt8/
         lREg==
X-Forwarded-Encrypted: i=1; AJvYcCWzFATZxMVcYlGwr801UlXnOjRwt0NrmEm/NEK6AKI9qfJlMfou0ZX6eF6OUvkmqdtXVOEXa6Psd073SEYniNS5ISg31NLQF64FPLr8
X-Gm-Message-State: AOJu0Yx1N48EehvfrTqa9CK9rQaJHRJxEeJnvN3dTickiIIkCVFBlv5O
	AvTSFqcgIt+TGh1mIsOT21s3iA902VNjj9DDDDl/FSa8MA6XLYJ1xxQGNZ+XKg==
X-Google-Smtp-Source: AGHT+IEiUV78v4OyDNYTQJ/rL2/MwBFA9iNAMaCfTqIv6x+qoAInhK8ZaE73eDO/HyzNjqQHoqDN3g==
X-Received: by 2002:a05:6a00:13a3:b0:6ea:b69a:7c70 with SMTP id t35-20020a056a0013a300b006eab69a7c70mr825437pfg.34.1712181245390;
        Wed, 03 Apr 2024 14:54:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kt1-20020a056a004ba100b006eae6c8d2c3sm10516881pfb.106.2024.04.03.14.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:54:04 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Set file_handle::handle_bytes before referencing file_handle::f_handle
Date: Wed,  3 Apr 2024 14:54:03 -0700
Message-Id: <20240403215358.work.365-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=keescook@chromium.org;
 h=from:subject:message-id; bh=iQVFWLJ69AonJ7RrN7NlN9bDUbprCHUU+71zAbs8w88=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmDc/6H7alh0B6TVjRvaoj9tj+S8i/H4cugB5L5
 Chzk/m/q0CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZg3P+gAKCRCJcvTf3G3A
 Jiz9D/9xoda+JjArsGSrjkvnflCSblOHq+w37ybPQ/5cInqaZEYDwUkQEXMMi4PNHKSj2oYglPF
 Cu07odSugJ1sk46ckYSrF9iNGhnJzTjacivFOPR7SfqJYNZDJ2Urc946DjHpIZ0OH5D7m8Ca+Zi
 QOJG2QMHSN+orW1DScb2PFXS8PAUH1yp5mMZ9etVJrrKUYbhxtrCXKMoeiduk6fhriSLRjDX3f4
 1lrIGKTwC53kOmmPN49YJ7EEqjkLn0wbLGBPOQkuPa5i0ycRw4KNgOB+1nINEedae5XBplhdiuX
 V+eyC8i4bIGp2sEDcEzLe/MtNG2eMhk+lODN4PGJu1wCTNi1cOS9yKeBJHqwZcOko8QSkzWqhO0
 6QmyD4gIf+xoRU37EOCnE9m57v3z2IdCmv3L5bLEpfYB+XdO3SIX+1PKCSGjVMFpIC1GlvV3ZU6
 eR3/HyWGGiFw2GaHHkPaXdn67lDDxGi+HX45xwMoeM92qwxcSb/hw5OKKrSU0qn5Ti++4NV5wCv
 laXgURTzxSlCnwVp/HipmrGwRM944KL9voOfvsnl7Yv2cfYHoyWT3cZW9XG08AtyLca1pEGP6K3
 dFMBPcJ3UtGKk+uhI4+1im/J+9p+7p36QoEHM7tJmNnaXo+ZktH1heNAkvjTyGhrVBmsBRizzse
 vETTyAt bh3OZAlg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With adding __counted_by(handle_bytes) to struct file_handle, we need
to explicitly set it in the one place it wasn't yet happening prior to
accessing the flex array "f_handle".

Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Christian Brauner <brauner@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 fs/fhandle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 53ed54711cd2..08ec2340dd22 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -40,6 +40,7 @@ static long do_sys_name_to_handle(const struct path *path,
 			 GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
+	handle->handle_bytes = f_handle.handle_bytes;
 
 	/* convert handle size to multiple of sizeof(u32) */
 	handle_dwords = f_handle.handle_bytes >> 2;
-- 
2.34.1


