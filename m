Return-Path: <linux-kernel+bounces-49660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A7846DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3411C248E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509B37F7D6;
	Fri,  2 Feb 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvRP8dJ3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26A7C098
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869011; cv=none; b=fPbdenP7wN5bvxupbMMxarOZLMnccABPo8FDYv3En88ASnGFd5zjvRjw737R3e+g2/JGL9er7dZ17tyAlb7h2sW4lkUsLHqD3CHxPdJqcajsJTOYhkjkQ+63/kluU+jrIj9KH7yfr73dECr5ihdD+ZSKJY8r3JYKLfSrU05wqr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869011; c=relaxed/simple;
	bh=ZxwmE0nZsP1Nk3oxW4DdUpU7gFnVfTpHfJ1XVp+L1j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNjn99aSPixuaXDPF0q9prV2KECx/HHMYg7ltUQsPhuwaUbLJi7j6Yur57SK7LvDehG2xGirjLGqFyQxQYAYyYSK4PBFjIGojfxRmUo7dsi7fKfqsFL6OB63EhljhO/2bVMxt/PjKtsIBpx+AHuzuQ5ZJ5n8mrZXDWi7peptZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gvRP8dJ3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d95d67ff45so9813145ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706869005; x=1707473805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huDkFM2jKbuwvr+cQsGrJ0cboThbc1r4eSZ54RE7EeI=;
        b=gvRP8dJ3KXsujD0C1Ta3pPfDymJdYPCHYsuftj1ON/YnSJA3tm2+UZn1SeXbdriLn1
         lcezB3u2mUWEC2MoVexnQ1sm9UrJqy4yfJwh7+oLWPxKtWOYoExkaMWHDzWHJnTJpRrk
         pABBhJW4wUI8AAriCqjzK41YNwsPbDVxYwhkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869005; x=1707473805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huDkFM2jKbuwvr+cQsGrJ0cboThbc1r4eSZ54RE7EeI=;
        b=Aq+7lFrsMxAKLPTe0NiGBvJGmYZeFCR+J3jHv76oalwLIo56/N+/mWWuqZe7dvLEaZ
         7tzkHXjD+pZxlHZYkRqefCJxdRlsjpN88eXIjjUhdhEnl2iuiRbCXFD3FW3o0aIndusD
         D9x4kLybglEYUhpaXLV44xjYgl2+gQOu+ChAFFwhp0wKtBIaaUup3ri0GfhJc7aaDAE+
         KmIeJUm3oFI8L6r3Q747Q4BR37FjXwELCfa/RSGXVyW9JWgRi0udPdhRjZoATtKkVc6J
         79Pir/F9ymQwaW6H3pwDE2ZC7iGQpG7DrHnZFQK7Fj902xqTcUTDyaTC/jDop5E1iAPw
         XE6w==
X-Gm-Message-State: AOJu0YxRRP84F6RhEtgvzwIbZ21hG5lyukFcZ1cYJ8+UUaSyjQij8y1B
	mnVtB0rzUrUuJODP2a+Qf2qnTf2JuBtKh7uTvSdgFygg+wE37k0If0OWi9LLbw==
X-Google-Smtp-Source: AGHT+IHjZ/RlOFhGarz6cIg2WBEenEsLGnouU4y+LgMxrAEpF+gSHjnEyIr3C9MYyj8jvC/08bJKHQ==
X-Received: by 2002:a17:903:94d:b0:1d8:b6c8:d9e0 with SMTP id ma13-20020a170903094d00b001d8b6c8d9e0mr1942830plb.68.1706869004906;
        Fri, 02 Feb 2024 02:16:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXm2ltGXSQ3/dMDFTJd44WjKZdXshEPXPWN2y6WE7E3b+jubgNaOYkuw5VnqA4S9HtLo7qrYKsGKPoYxH5O74AVwvWb9iE10rFYm3n026lPQhoITT6P5EG3S6E0ARfoiPiilFHc1P170f3L7IIRjKqdWIGevmKqtcYBEq7HSe5RdITj0U96a6pTvHsJ0MsK89PKSs0ECjcxeR0yzhKvgzBGQqSm8nHFrtSeBcJzXXMaebLLOFOmheGxxf2ic7AR58qnNPxprUyVeY6wzFzi0cNWRnRpzjgIFyrNRmmyNKPD3NRk/rVYnE+xKRRmrDd7B9gCDwG/+ve4xCBvu8plPkZxiwuj9XZhaBIbvySbpOS8aXTc+kkoQ0Qr2U1llnNgaFQ1nY7H3f/ojjTTW/r7ggMMWTwS5GebQqKR5ZQk4UXJjEiv18IkKd03pIO+QQHhwRvi75ST2re8QSg/NZZvCu22i34f/ZfVkuhFBAKeP0EdJTIi3pDLw2DCTd0qk2OzZQ3esIyeHUi4SbRQEhDRzSl/EdxhSOD37RLyKKeZsvcQw/KOdAqAawSDSPy0Zwzh0G32VHyd7skIHFuGmVRga32CpsILSaLLA4ITFo88rafydugjzXu00x+4wzcP6wX8+lbazQTj
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jv5-20020a170903058500b001d8fb2591a6sm1262459plb.171.2024.02.02.02.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:16:42 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Fangrui Song <maskray@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/6] ubsan: Use Clang's -fsanitize-trap=undefined option
Date: Fri,  2 Feb 2024 02:16:34 -0800
Message-Id: <20240202101642.156588-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101311.it.893-kees@kernel.org>
References: <20240202101311.it.893-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=keescook@chromium.org;
 h=from:subject; bh=ZxwmE0nZsP1Nk3oxW4DdUpU7gFnVfTpHfJ1XVp+L1j0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlvMEHvUSDUiKlA+mbRPre0Ef3vI3/FZn+MH1H0
 nTpBmdXXdWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbzBBwAKCRCJcvTf3G3A
 JpS9D/0Q6QBoQC8jBK/SWwnCyPlA7roqa2Ww1Yr5HWnO8NGYyqLoAR/MLiePscunq9kQo7XF14S
 P8vBlWa3w59PmmPOE6/K+Yo4XhNmZJHNn57MFcpldH9PXBny2KEOQhIlpz0+Qq7zhOLddFXdahg
 miGo2qdGlfIpjGAwlRLZVr4XDKEdKus3gLReWRkeV1eaUGK+SU4BE0S9e5Ucv2MjqDKeYkX5U8P
 qcJlKCdupyTdD22vLQjZ4hg0UIOxJJ0JvKAgP5koezT5XzlYxQPfD+lFdixQeprPlZX44YEoD1u
 2gFGFM/Q8utBzYdgJDHKWh8ZFe9OdEKUCuYvCh/uj3WvrNcdeiAwxXTFx+YFw7lp/nUQ9zNbifH
 i0lKwy9Brl+6w2SYcs69qdsxG5hhti2yLUQW5qr1cxQetC9HV+eqLTMxbCd+Gm8bec7x5A7gPkl
 z9qKNMgq9aRbauhd0kdkjl+d6TuQcysN/udCqYNxsTkdS7yBgm/IdQ7OZjnlsgDA30jgME0SH/I
 ACfSg1lLhSUiA5YoWC7kX0F96o0tirE4vqzxv/Puh7Cw53eqsLhs+IiSDSXdodWu7vsBW7YDlsh
 iWO7s+1g4L7hMvsHJrbpcnHePzJ54JOQLt5okcZPy+IE+zSi6oA38qRXNbFz3mjkKY40YEX37q4 8g1LnhWR9uKDhnA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Clang changed the way it enables UBSan trapping mode. Update the Makefile
logic to discover it.

Suggested-by: Fangrui Song <maskray@google.com>
Link: https://lore.kernel.org/lkml/CAFP8O3JivZh+AAV7N90Nk7U2BHRNST6MRP0zHtfQ-Vj0m4+pDA@mail.gmail.com/
Reviewed-by: Fangrui Song <maskray@google.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.ubsan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 4749865c1b2c..7cf42231042b 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -10,6 +10,6 @@ ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
 ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
 ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
 ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
-ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= -fsanitize-undefined-trap-on-error
+ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
 
 export CFLAGS_UBSAN := $(ubsan-cflags-y)
-- 
2.34.1


