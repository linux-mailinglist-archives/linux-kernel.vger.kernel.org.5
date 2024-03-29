Return-Path: <linux-kernel+bounces-124005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A7A89110B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891D81C2845D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6485628;
	Fri, 29 Mar 2024 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RH0NkW3B"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2407BAEC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677300; cv=none; b=QTvRRd8POtrR2m2M2lvuusQQN/D+Nwkkv56x5cNAhwbSIB8F2fg6pdWcZpFoCoMMngZBBOiGRCcFBgSpz1/FsIANUediY0xz9rso1BHc7Q0uTI3UEynCxt1h89rGGx61jr+tlx20q+xuFwcN2IYXr1JPXh8YupjvIWDLY4iaov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677300; c=relaxed/simple;
	bh=9iXCNP+EW0+2+JC2nl2OoNy89uZqvybM8NUQJ2K/ih4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KTUKf+DMyN0JZf6yAL50qjarz8Yo2MEoy694zRRtWps6EbmEduy0eryT1b96lWvGbgCEA1NvEi1KrIPkoHBcA58m37kKq1G1Wlppuvd7vxjYpJoexjbbcbDPLKaxAU9V8Fx2GzPw0Hd8GeRV8qXb6YRkjGXMEf5LX2IZ2fM1jvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RH0NkW3B; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso2959483276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677297; x=1712282097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmiND9fJytE7hp4aS6EZvp2Qf4FYwUyLzLHSobY4D+U=;
        b=RH0NkW3B64RQtwllzuYjxkJLeWIXvju90EGmkhpDAz0nu27JSAa8QfHI3qW91Vqow+
         eRXrh0VfoR/RqJXz9uPpOW9nnkwroxtdVxgvB4pEoRVZdrKSJ/BaFrWhT8nhwXouMuE7
         DuVQbnWdIAXCWUWT4cEr9RUtloHYA0IxI7huyL16H040Xc5u8FQg7bGz53WOyIGrEjgS
         zJS2In2dshIrjarZ0Y6nr8UbNEn9WON+ce0oQnx0RKdEoIjFOCbiLF6Cth/OKtBVlIeq
         LBEdaDwUPogsXUH6HIvcXNM472ZnUFGwQENthMc1Bc1hsSGKCE27Y7oR0gYUmYXWeaER
         4x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677297; x=1712282097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmiND9fJytE7hp4aS6EZvp2Qf4FYwUyLzLHSobY4D+U=;
        b=mfAmldtEof39E0pOmFtvpp8HF45QJNxobTKqD6cc0qKHq/lgDKZX9IYo5lED48Bswc
         h9NMqiQrM6RXhC7jPc4mDcS0b3yw1hNTIUS3oxRUHRPqWYebjoSC6SKfvBn3OTLwtsWW
         38eF/NhQsFw+4Elx0vhB0fDZhvKvBAY5nXXZ2SUQgY2AqAvMeO39gCAwVIsoN7CXmwOg
         Eu/ITJFkpiKM1vNHN2joAd7IXXSdUJmaE+Xau/zZy68f9UKW5II6Wtp8z8gef41dPMGb
         s13OrrHXE1VkdquVb75tvOONIkZQh2p7nL6aayQ2XJCz71BwHntF78HsVmiPDC4pg/hY
         tXCg==
X-Forwarded-Encrypted: i=1; AJvYcCWv6oaxklWSlmC7zACTQwj//JPfduGewrgK5nH3PHbfTGVrUKnmq+z+0WQicpDKXni9/FNulKt3zgM5j7lwt4Ws1cWMrV3lI4QRUORq
X-Gm-Message-State: AOJu0YwB0HkGtK3pjeBpRNV+TTfpA0SFyi8Tr/Y04pyKpYR39YEFpfF1
	QSFMJ8XA2UvPb2JaRIdAC5hCm/chRw6AG/hbhafTYlK38sQsB+y+WvZezjxdgAGgSma7+iaueYj
	x7Q==
X-Google-Smtp-Source: AGHT+IHeiHkMKp379qbywYMCr+diDVdq9JP2CxLadyp3LUxzIJLjH2ayb4pU1zwCCzZ0jFp6BgvxfUk/s6M=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:1004:b0:dda:c4ec:7db5 with SMTP id
 w4-20020a056902100400b00ddac4ec7db5mr365495ybt.4.1711677296744; Thu, 28 Mar
 2024 18:54:56 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:40 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-26-drosen@google.com>
Subject: [RFC PATCH v4 25/36] bpf: Increase struct_op max members
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

Fuse bpf goes a bit past the '64' limit here.
This doubles the limit, although fuse-bpf currently uses 66.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 785660810e6a..7a5a806e97ad 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1636,7 +1636,7 @@ struct bpf_token {
 struct bpf_struct_ops_value;
 struct btf_member;
 
-#define BPF_STRUCT_OPS_MAX_NR_MEMBERS 64
+#define BPF_STRUCT_OPS_MAX_NR_MEMBERS 128
 /**
  * struct bpf_struct_ops - A structure of callbacks allowing a subsystem to
  *			   define a BPF_MAP_TYPE_STRUCT_OPS map type composed
-- 
2.44.0.478.gd926399ef9-goog


