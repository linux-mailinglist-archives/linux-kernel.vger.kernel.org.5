Return-Path: <linux-kernel+bounces-104191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4207887CA79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740C51C21951
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E365179AA;
	Fri, 15 Mar 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIm6ayZn"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ABE1758B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494104; cv=none; b=XUtPsPiqr92Levp1Htr4Zy3+BwDfurN8OULf0jQUSDuzZf9AS5TRL5wrpWVF4oQFddtIE55UoadrS/GP8uo4FPHWp9dXlOVW2Wq7wWIJsGz0NWGf2qd1Fb7H6no/fJ04PwW3cD8/1JhJ3En9zOMolxgvYAONWUTMX7AJ5z5mkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494104; c=relaxed/simple;
	bh=s8YNiJQqowuZf+XZsxxS/0ZQiWZPcjTmWHxl7bNoeXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mVNOywDhZ+V53wk5K/YbkGzz8WVr/ia66mmqPHoYi6MYAC8T0yj9JjOOUcc2MoeMz0tB5XoYjbz1rBMF447HXermwYs4I3ZPAR17qkiTeQbmrernXVpz9aLmnpX9CdVg2SBpih3Wl3Cs58u0OuKmwN6nZPBooy09Mq3mhTpG3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIm6ayZn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-568ac71eedaso215383a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710494101; x=1711098901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QsvIcmB6q11qBlE1k9pcuOdnVgySpwfRcM8NSNvHquc=;
        b=JIm6ayZny4KvPavVJFZLSebpnen8vJ56idetkiB+02VoCgWKgpi/o0DJQa/4Pl7q1s
         5G45zfYhpD0STV8z8nktdCaIc99cEtBGjHYCKS/HyO7s+iGgaqMUzUzV/2vYZgoG65tt
         R7/MY+P7tKdODiuORjtUjNvgUzB7I9e6XK6Wci9eXNvA8O2WoDpRGjoQOZyIzZFsG5h+
         uo4wpuoRp571nNlYVWsQC3Xbcf21WpS+XH3Ljn4DYy93S6jhfNm5HhfIb+8XYKKot/jG
         S3vbGmNHcn7vvG2J7qpDZ/JWStMS1IVEh/bnR0eF/Q07+d2DXTgNaYLJXcCIEZY7tQ3e
         gXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710494101; x=1711098901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsvIcmB6q11qBlE1k9pcuOdnVgySpwfRcM8NSNvHquc=;
        b=w6g039cfK8ms2AnP82a9UB+vPl6jwaMmWPfiNRnqim+fj9JAJUHWE/cjcDRCqgqXFk
         Wgk/ICTKvBVN+EvuLNNPB974qkEDNagjtnf4YyvHRqWjrMHXElZWtwF/j8LEf+sIkAEa
         DCJhHv5NBOEejwyDaW00xgBIqFOXeibLDk7xwqxReJ8a+reOfPkrCrFY+482r2vSQ9qc
         mdUxttaMBxODI1r491REx2PZ+d8FLodikh8oGxZIwnpb/0XJfPZVZv6Vp5W+Y/t28f05
         Y2zCwyaA5weiSXlbTp5G5hweY9LbLtf+G/DrszyKnqlM4xcH0AsZ5OwYLLLxsw24wQJ+
         FY3Q==
X-Gm-Message-State: AOJu0YylO0vxzMnlwi3aIi6lQj74tAoK2E6gndGYuMGglZcuFW6HMg6a
	ulN/ErTHwlLuIHAHKZrRMw1YclgSXCXJTz6vvsPaTT5Io7gEo/VnScRRddjGL6k=
X-Google-Smtp-Source: AGHT+IFVn+QKlOWff5qOU3QNlE3EL84E5qMXfzbrDjk9BTg4nPfsVr4HqVnj7DzLykUOQrsrPQMeAA==
X-Received: by 2002:a17:906:3097:b0:a3f:1250:5c3e with SMTP id 23-20020a170906309700b00a3f12505c3emr2574061ejv.0.1710494100715;
        Fri, 15 Mar 2024 02:15:00 -0700 (PDT)
Received: from localhost.localdomain ([87.201.87.115])
        by smtp.gmail.com with ESMTPSA id qk26-20020a170906d9da00b00a45bb14b1a5sm1505836ejb.89.2024.03.15.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:15:00 -0700 (PDT)
From: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dxu@dxuuu.xyz,
	dmitrii.bundin.a@gmail.com,
	vmalik@redhat.com,
	ast@kernel.org,
	andrii@kernel.org,
	ndesaulniers@google.com
Subject: [PATCH] tools/resolve_btfids: Include linux/types.h
Date: Fri, 15 Mar 2024 12:14:34 +0300
Message-Id: <20240315091434.10622-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When compiling the kernel there's no type definition for u32 within the
translation unit causing compilation errors of the following format:

btf_ids.h:7:2: error: unknown type name ‘u32’

To avoid such errors it's possible to include the common header file
linux/types.h containing the required definition.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---
 tools/include/linux/btf_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 72535f00572f..7969607efe0d 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_BTF_IDS_H
 #define _LINUX_BTF_IDS_H
 
+#include <linux/types.h>
+
 struct btf_id_set {
 	u32 cnt;
 	u32 ids[];
-- 
2.17.1


