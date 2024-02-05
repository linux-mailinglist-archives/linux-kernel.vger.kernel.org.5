Return-Path: <linux-kernel+bounces-52268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA98849616
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9023928211A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75852125BD;
	Mon,  5 Feb 2024 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="APci+XTF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE511CB3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124356; cv=none; b=hsdOnteSabzSlqdvlk+J+SmtZw0LpAl+a1mfPxmP983cGDEKbGlmCRH9i9oGoguaTbBwWMGOCURD/cM+TyVlgSvo/xLYxPW8LHydjtuJfshTvpukbAfQ6o8uONx+Ss4tFqSnoz0kHVS7zVL2mk3cyldrEskqQOjvyRQvqVt7GCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124356; c=relaxed/simple;
	bh=760BS4AYHlS+7APUtQ8ZE5dhudg+2LRRSReX7Wgj0Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fLw/QZM1vvOXEYcNP5hNoz0if7Zh7QUkjurtD6tt8tNYTVCGQiov7D3Uw0uZ43CtufdYpLDjJmWsWgvw/Gazz7SxKQT+3noorB/ejFGGhUdTsnvTFTNTXdRtfzIc6q2PM3NJ6i7hqNRmF+En5WySnusqhwkSLFTHqnArN6MDbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=APci+XTF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d9b2400910so4060995ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707124354; x=1707729154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYWUAgEEnr1pXCEFzb/tx17d+1YCXeUfaMMfEveY+ng=;
        b=APci+XTFC6KesbeBl1rT2w2/QGPyfTuxzY8L5cCsU8zjKTHv8IWv71QKlOcVePKgy+
         Ovg1CCJyRZumR/px7rcY59ScaKSnQVptb0PIlCK2RT8icKzHFIWHrK0OuUZ7Ulkse3KM
         UtvUO7gQA4z3kCLUrga31BER4rdiWpldfFf5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124354; x=1707729154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYWUAgEEnr1pXCEFzb/tx17d+1YCXeUfaMMfEveY+ng=;
        b=IEx81iEnjadp7IMcQUYZqCBTc+4pfgplfFBT+lXKnkLxm/bRgCrDOVxT/7ju7gtSXZ
         04mYoVccM4kHQGGGlx5XJf4G05mARYT0rSeqwIOHzaMetcqEfadqZ1F7mnlrtGy7BBEc
         Nfwii2a861DNmA7bSKazR9T2rQz0ZDITNzn78q9x6sFOES2rRjuaCx5c594wLL0EOonN
         kv9qtMf5gCBo9EVb+runWYuKbp/zLh4aHNyKDoWdSuBDeqJUx0VJWgUZJAY8l1cp54UN
         7sWyT7BX1+o6K5CB84eBYi6ke0nswUQsidiBQL8qRq6dLHs81lw+pmKrIbJ9fU7uU1fE
         7C+A==
X-Gm-Message-State: AOJu0YyOqScymXhpH0Or+T9YLwXknVTbQ3VghK7NN0mc2GqgZfUxghqh
	FKc4SCpdoFTJLrhfLIf9GR6mvWlD8frhxwb+HQOv9bOtvY340UDMD90YQBA1hg==
X-Google-Smtp-Source: AGHT+IH66VqUGkatm1uMetl8y/UtE2gkAq45ydhKPyLzIK/EnRUC1ZOwcGbvNAQJxde79gjYhIxP0g==
X-Received: by 2002:a17:902:ecc6:b0:1d8:cfc9:a323 with SMTP id a6-20020a170902ecc600b001d8cfc9a323mr7797777plh.34.1707124354619;
        Mon, 05 Feb 2024 01:12:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWgSNahtLSIgi1oJactmW9CzmKhGIeggdJCMbvIAO1oFLET/U42l1zNWd013Q+ibSRvNrDdKs8waJXDHI4WgVffxL33sN8OJFAoU+t3kpZ+Mh4lMLuJjUkWtfr26ZAyEJ4H/bUdk7UJVZ+1SsjGMcfIgFMh5Ove5ghFIgm5Azqe4Dms0tHmf6IhbEG2T8MYN2JdD0dTp3aZI8wDFknfpFxUHA0hBXxXVg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz5-20020a170902ef8500b001d8f111804asm5806487plb.113.2024.02.05.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:12:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] overflow: Introduce wrapping helpers
Date: Mon,  5 Feb 2024 01:12:28 -0800
Message-Id: <20240205090854.make.507-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=keescook@chromium.org;
 h=from:subject:message-id; bh=760BS4AYHlS+7APUtQ8ZE5dhudg+2LRRSReX7Wgj0Uc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwKZ/jXO8LRx9LKVfIpgLMA3HnC9RB3QapN1aA
 E6+Ua64vueJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcCmfwAKCRCJcvTf3G3A
 JuynD/4spaVIpyJgrv36zn6RAwRgIkf5r8K6RyH+nDsnlwsos2S/01Q3qqMdCT2oYXJq4I59XOy
 TQXT5p4T7EQhDViZjlRDTvKc0urPTQlFTy5DRDZmCa0Mcw5IGrleMSK8IZObean190vqwESAnLj
 TOGrsopb0TGZ7nmU1NIav8+KLp35bv5Xlzv6AdxlH8oBzn/Sy2EAFpHOlP1eRK581CZyjJMaMvt
 Ui3wohwjU8c0zjPgOjuAKG5VSx9nNP5KTwCWkgUYNoCBhkUZ6/kgt0FLaV+iEpePwkUQFAf46n8
 BOtxf4Cwhxk4Az7uEfEV64t4MskJWd3N/CL2hlV9W3qa/KR/JEgk8waWVeMDmuRV5RA1c0tfdTo
 E1DzbPB3EZyua1nCLw54cYp/cv+/Cy+sPJkJDrUCht1+cIdv4qHwrw3zSumudSqVCQjfZpvkOlV
 g4rWMwxOWMRZDG1s6F0Si48YRuiBYgCoklaEkXAhUCCG2EywiMnP5J2Tweag3PlKWEQ/ARL0kx8
 kSoDMS+9nK2a5As7A0ZZ+v53htMX2PPdAA+YsM8SiZEKFcbCrG1Zw9WuOFTCQX0clAtDITKTZuq
 SofIXJFtT3jCWSLgGStkEQk8MX7LX2hcIHpADV166wQd/wq/UAVdRe5XkaE1J5ouVQ6dWBtQrA/
 uh45CBG wK8vAF6w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

v3:
 - reduce patches to just docs and new helpers; we don't need pointer fixes yet.
v2: https://lore.kernel.org/all/20240130220218.it.154-kees@kernel.org/
v1: https://lore.kernel.org/lkml/20240129182845.work.694-kees@kernel.org/

In preparation for gaining instrumentation for signed[1], unsigned[2], and
pointer[3] wrap-around, expand the overflow header to include wrap-around
helpers that can be used to annotate arithmetic where wrapped calculations
are expected (e.g. atomics).

After spending time getting the unsigned integer wrap-around sanitizer
running warning-free on a basic x86_64 boot[4], I think the *_wrap()
helpers first argument being the output type makes the most sense (as
suggested by Rasmus).

-Kees

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/overflow/enable-unsigned-sanitizer [4]

Kees Cook (3):
  overflow: Adjust check_*_overflow() kern-doc to reflect results
  overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
  overflow: Introduce inc_wrap() and dec_wrap()

 include/linux/overflow.h | 100 ++++++++++++++++++++++++++++++++++-----
 lib/overflow_kunit.c     |  65 +++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 16 deletions(-)

-- 
2.34.1


