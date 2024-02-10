Return-Path: <linux-kernel+bounces-60209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B05850174
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAED2897B5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E98442C;
	Sat, 10 Feb 2024 01:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NZ7z1jDm"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD951FB3
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527807; cv=none; b=By1H3fjd2ImU8EVRzskB2gt5faFhwwP9FvQFgUlxX5d1ahHxCEZLOxxvaKcgLHQR0E8eoSaNBMkK7/Lz8R9h17FTJiHHiMP6+ctqctioteM1gi6N78FlVNFx6gP0ME3di2jRhNJqaDY4oOALJg3bvtAGJYLpnhb/TvZEnFb8XT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527807; c=relaxed/simple;
	bh=LjE7ZHH8ae5qMsodwhs2U36vGYqe75wMOHw6PFWF9AE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IGKXXfI8ooV6COia5tMXK9WSihjvY1Nnx0Eo2fsLcpyzNjPilaPa8liUGPy6FHmPfBo1WGiibQfdYIKy/yiUNN6TjQVPY4hG0j7pQBZyH9QQy/0TZlFKBh4cT9y6FPklWXfw4jEiUyaWwT6Ndcm9e2LzGs3nP299bc8enXOuqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NZ7z1jDm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so1061011a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 17:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707527806; x=1708132606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lynoXk2e8t7moiB6PjCqroJY6cl9fHkm6incU3soZ3w=;
        b=NZ7z1jDm8BAYWOvls8fjZytdpAhOtIo4n7VmIfugnwCHGnj5KrkC1sqYEhzkxpkrRO
         s/nxAgMxEz9JHzZz4aUVvdBubDZg3MfS4yFyfRFzy+h4knIfBAnixvDZGE+I7qFUPQxN
         PGzXYyijv5BlU17iYRUhsPp/oubxYKUJt4e9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707527806; x=1708132606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lynoXk2e8t7moiB6PjCqroJY6cl9fHkm6incU3soZ3w=;
        b=ti6MrRTjSE0BIDu0LP4mx24MKNniSaXahYuNlMegi0rfgFige5NuvIBFl8k7rgzJ0h
         bW/Rjv56wPNlLvIceLcinscgdR9hPnLiwEkRUeDRxNIAfkdoqkRHFE2CRf9yTxHCDt8H
         W94n++8o0+zNw+bg1ok1ka2tPhWLuu5KLtbdpheCe+D5q/DRmSnNSUGtHntxsDKktNjb
         +rWxD5YHG0CYOGKvT2RqhRARGJv7Zi68k4dJK7qHRiJ1A+FJc7PaCiOSIE1sq5tUhOED
         IM9jKBszE2u5u85d2roP/eKmgOVDMcK2bByS9DB5H+cBo4qI6FJew7hTkYko+gYC1PRD
         3wNA==
X-Forwarded-Encrypted: i=1; AJvYcCW7nopZbGIgbtoZe46k1XPdFnnSQOSgatc8xLW6IjGscGUyOY1uD/PpYH5DIuIroiMY47sQvokqxSBp4qCE0x99/9To4TamMWCgU/tm
X-Gm-Message-State: AOJu0YwXak/K1IX1/Mc69yTGmXBSdeu8C4hJom+0DU3cJiGU1P+IZrII
	QkvlqCuluk9h7d55EGScjuezCZj+76+gwvE/NEjgPnZDtfcoIzwQuHd2jsLERA==
X-Google-Smtp-Source: AGHT+IEa4UolbVKatHcbt+cOYgbS9oWPYEU32EkcR9iaUPsGADdWcfzc/f0146FOB7f21z75zxUz6w==
X-Received: by 2002:a05:6a20:9c8b:b0:19e:a1ae:944e with SMTP id mj11-20020a056a209c8b00b0019ea1ae944emr1032895pzb.37.1707527805847;
        Fri, 09 Feb 2024 17:16:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbpj9X4EW+IsuXY65W8NCQ77Ve63MRwZ9v0hVMOEFlWHp6XsrVDzXNHjRD3/EjbLMLlTi8GajZ3krAQxM+apEYMuvZh3C/BXJW2Ul2A87DIpaLw9uKIKT15qBRGr0uCY9gT6RItdAsLYQnMU/qdyLyDoAJG++neSQ6wOpiiNJPZhTO2AY2B6RLH4VRmT+wjSUEKjkYa8wcStKko7UnVXVHGIE7PmIeoZz4b5ZBc9dNzMx2m7oJ4TKYQuWRdtfwzzEzyjAaa0Guls96G1hIYS6KFkX+CcRhvzZ7DYiZ4+ThGlncJkWEe8PGm0FNU4lBZkJD+a5dUyaWmqh3HHNZOfETVHb8KZChW9g6e55dWlzpU8nsMXQeEBP8+QQoruYWYTfA2YxT55zm1ZSylDD7xIGi4zN72pJ3qH36y3V8XsWiQRl5gN0wQyLW+WyY2WQQax1nFFiuVTauS9nx8GicpHP+jKwT2AGGEeu02RG3odDx9GJimK5C/qjpthEk8btL
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m19-20020a170902c45300b001d960a29da2sm2097473plm.62.2024.02.09.17.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 17:16:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] stddef: Allow attributes to be used when creating flex arrays
Date: Fri,  9 Feb 2024 17:16:40 -0800
Message-Id: <20240210011452.work.985-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=631; i=keescook@chromium.org;
 h=from:subject:message-id; bh=LjE7ZHH8ae5qMsodwhs2U36vGYqe75wMOHw6PFWF9AE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlxs56CjBFfgU8SL4TcnflI84OzxGZaGCzXUwyD
 deewc09Y96JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcbOegAKCRCJcvTf3G3A
 JtV0D/9vYG6bnLydYrwF5KJxu7AlrI6LOPHKy3XOwsVbevcBwCkIhJ+ys+omM7o7Z6MLLp8fAwR
 vrQT5uqePajGvgcXsKtQBvzBxPMpS8CM5iJRn7Y1X5UTC+aFJtKiHoYYQXinHFioO9mobDrT/Nj
 eYV22Sl/LG7i92iLbjTuPOmuhsxRakLiVu9zNICvd+3LPlXrNDg58yloa4t5MQ2bUQInd/UCjwZ
 h+PZc6qzGAemw8zdnMr7KsMpFKI/PFzHphK3mkEtmRz7MZpPx1eKkxIuaV/TVbNxoFjZ/UdoTYE
 QPr14m1zemajq/+78yh3YyfvOnsJm8/uLfa28KDoV3hfGWJxQUPN4nIDDQCrtt7l2JExaq1kzy7
 OzCBrGa9KoYHZ6ZjA+8+DAeII5jBpVbm1OBy7VPdiFEPp1qR/9aEz/Ak0en9fW2YvUl1UigiTXh
 ABbGlaUnDxmG9CwElcqMGpHmQZ2buq1uxN4A51fUgi1fRF94qbbfmZdwGrRt3+El2W3Fkmzwwaq
 Rm14E2+cnrcRzSfABt7WsCiuiXdemzzBe9VSsfeCrS6wKRc5XnOSGnAo89gnfA/RMKE/z4mDHid
 +BAlSCzPV4GSHaYFzqlLYsBK7gyhUzq2nz5I310hm4n4pgjTewei6rSsCVCIpkrZg4W8EXzbUJi
 GF4RjB3P VW3rBkA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

We're going to have more cases where we need to apply attributes
(e.g. __counted_by) to struct members that have been declared with
DECLARE_FLEX_ARRAY. Add a new ..._ATTR helper to allow for this and
annotate one such user in linux/in.h.

-Kees

Kees Cook (2):
  stddef: Allow attributes to be used when creating flex arrays
  net/ipv4: Annotate imsf_slist_flex with __counted_by(imsf_numsrc)

 include/linux/stddef.h      | 16 ++++++++++++++--
 include/uapi/linux/in.h     |  3 ++-
 include/uapi/linux/stddef.h | 25 +++++++++++++++++++------
 3 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.34.1


