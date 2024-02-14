Return-Path: <linux-kernel+bounces-64665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD985413E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E223228A933
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA993BA30;
	Wed, 14 Feb 2024 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7RjFgal"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D9111A2;
	Wed, 14 Feb 2024 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873930; cv=none; b=eynaiyhMbPZPLjpIZlqf0OuzoKO+2hR42jGpVcJssxK0JzpVs8wkUqJHHlqfO9TAjuOp9rXbGPFefcAgI8RGIfBDnYAeW7tbffhow6C35v9pvCGHUCn/HiW5WfgkoG5fndNbShyRv1xQu5ZUgo4vLf4dh+bvYNmDECH5XDm6oVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873930; c=relaxed/simple;
	bh=BxrbZG78mhySk/vs4GuYCVqBb7nK8xSAta5ewnnEwbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdV5aSOD+n3raZlK8DQHrjUmcA5Hs1Fc7CR6573FnCymS7jhef+x9TCcwPDFeKcfhl/EFJrxapDqTOqaKi54qeXlROw+sCXC+zHZN9KIvSqK5kCEPM45P/gQPLjplM10JzxUktDRStP5pJKZgo/gJZVLuFkX4YKD/AnAukt8z1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7RjFgal; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21cab5e5528so441991fac.0;
        Tue, 13 Feb 2024 17:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707873927; x=1708478727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sLqoPJITx4zipG5AwnBaabPkeaccv/ydfFvCORtqBw=;
        b=k7RjFgalBCb2H6fdXiCrhTpr4sNtnDVPcpdA/Xn6vWT+1gU4FiEv7tTno/kKp+QIhv
         wjzA9JPpmVoEGoCREr4qfomnGCE/rHCHbc8LsSk+MNFqXpobJF5svAfTBf1ps7OoyQhS
         A79iVWO5bOa0QfEPArksnZKAVYquOSrEIC4/GV9LZNAoa9Z5tPFHYw1AGDhISn5+7/Qt
         kjFgWBxhjecExsqIOZebH5eHUNnh1aWoYtMFKK94dQOPq0CQgyYU+I1jv/eko8uBNGOY
         z1MV807LsZaMxqqnPW2RKX9FSqytK5Uxr73qoAM+pm+YwOeMio90kpGJHhyfFZH3Qzw2
         tWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873927; x=1708478727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sLqoPJITx4zipG5AwnBaabPkeaccv/ydfFvCORtqBw=;
        b=a03VtKNRf73L/ImPltlAnBoYE0kEQdRsayUuKGJi6ba3gtBsmYDiBfTJJIwMszFvqg
         5XAs0bKUdJ5Qa1/JmJCe5tiOseY+Kf4o7F6+3cKMtKw0swjatB62fS3r1YkTVSbn98aF
         IPMOgEgOXuu8E7TipBUvk7vrRJ+2z1ZpcVd1Jv5sISaj93xSI2wY0NyP9XIX6VtL5SeH
         ig5O3EjKVkMi7ZvYjM6INnHsacC6XCMymLkOAw7UhEk6Blnxn2R8AE8n1E8kyhYVnp4X
         JNwJ/aL6jRyQVBSfmJzWt9geQOReDvszZP0eg/WpxqOs4J9xJf8xhauNPSm6a8GvjYTR
         RmJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyj7n02JndrjL7OCGRgFZZzTlNhkppEYrDB4fvdnrECv37Rj/paBrkufwEBCuhhIlO4ajLU6EDmPmaU1XeMKxeq8+MBRvBh+uTc4FnI66G2BxDShNevb+rtfNYIm1dlG/c/weWJpxaxvrY
X-Gm-Message-State: AOJu0YxZ8fJVIkzQ8eJOLfgvf6i86QJ4RCZb4Cr7+vHPBsbkhhFFPRap
	oHMI7JGwLBdhb7rq8f5HnQbYVX1uSLQaAYqeRf2BPenXVier6Dvl
X-Google-Smtp-Source: AGHT+IEXUKD+kOvDwLyOq7rOMY2ofbBYCXU7nT5An8YIVT6QAm8hMjllt2cNtqjDQzKdUahNpNrc3A==
X-Received: by 2002:a05:6871:1cc:b0:21a:866e:f4da with SMTP id q12-20020a05687101cc00b0021a866ef4damr1083554oad.52.1707873927452;
        Tue, 13 Feb 2024 17:25:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUt+APFGrpGqtlhjkdmd9JNaJcJG0vazdIukIU3wejUWXC3WuA1hG9ZtJfcabqkSj+oKf532xruynpjCatkDlnJZ6C4DHtesLHZx86PQ1jN+j6geuhcxt/qmguqLFrCfqESd0wfUPfqt8+DZbdCi9LMb9RcqgWaHKUAxvrxRa1XqMXpOHsicecimw2smUAyhC+8cXhve07zCNdCkPdKLhjrAme445x0N8Bg5RZSzgpSjyDzCC5McnXkTqQBZYEHc/yIjDKoF8YZoKzvJt5ZLHPUrTXrvcrCCxSWSAZI+Y+1+8XxCY3leiXPaMBjruBROti+KwrSC5UlhhRZRo9iqy3YKc93mbrzTocHo5O+ng6PhA7795V26Y6OG4LlrF4qO9NpnuBC+i8Yxa1Ri2Oz4Qfe5Ao=
Received: from my-computer.uh.edu ([129.7.0.170])
        by smtp.googlemail.com with ESMTPSA id pc7-20020a0568701ec700b0021a89fff00esm572928oab.19.2024.02.13.17.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 17:25:27 -0800 (PST)
From: Andrew Ballance <andrewjballance@gmail.com>
To: justinstitt@google.com
Cc: andrewjballance@gmail.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	masahiroy@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	nicolas@fjasle.eu,
	skhan@linuxfoundation.org
Subject: [PATCH v3 0/1] gen_compile_commands: fix invalid escape sequence warning
Date: Tue, 13 Feb 2024 19:23:04 -0600
Message-ID: <20240214012439.879134-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFhGd8pvhzehMGh1XEHBct7CGEQuF0CZeneMH3D6cKSRj5UdHQ@mail.gmail.com>
References: <CAFhGd8pvhzehMGh1XEHBct7CGEQuF0CZeneMH3D6cKSRj5UdHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this fixes the version in the commit. I did in fact have a vim moment.
this also uses a raw string as sugested.

thanks.

Andrew Ballance (1):
  gen_compile_commands: fix invalid escape sequence warning

 scripts/clang-tools/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


