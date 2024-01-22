Return-Path: <linux-kernel+bounces-32313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52898359F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD4B22DED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72C1FBA;
	Mon, 22 Jan 2024 04:04:04 +0000 (UTC)
Received: from out198-163.us.a.mail.aliyun.com (out198-163.us.a.mail.aliyun.com [47.90.198.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FE1C2D;
	Mon, 22 Jan 2024 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896244; cv=none; b=cplRWshcbkNX9ll0JMkrDwp0ji+ii0E1Sw1AJP/pU1SQtNTYOYh7pc2o5P+jlD5L0VfTQ2GcoZ0RXkIOOP50WVCDPwHuTFLQDjnYlor8sYZYwnrHPXsY70Bdt1C6lvU8kcRmaOuBMcwxt1raGloC5zSwnk32UiX6ZbOUCgD8LLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896244; c=relaxed/simple;
	bh=3uTSwpfMRwcsYBt+Dz+A8Ezli5jNjRKJfEuBqJRftCM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mJdHC4XDeLLPOw+c9orX3oBLm9Q3h/chnrHn5EeRk3wr7BdoLWHJu3DS32ytb9lHBjaNcin5jMMLsut/OjjAxBQFlHYrPFcCr8AIh+AtAv/ghS+SI415b+iNaE+b4/DqQjyPK9rmeX4X6p93BrJFrvnWT/OCQKKvBbjn5KIKeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibsd.com; spf=pass smtp.mailfrom=aibsd.com; arc=none smtp.client-ip=47.90.198.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibsd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aibsd.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436566|-1;BR=01201311R611S53rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00183697-6.09629e-05-0.998102;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.WBsaEmE_1705895283;
Received: from 192.168.31.5(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.WBsaEmE_1705895283)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 11:48:05 +0800
Message-ID: <d9ac2960-6644-4a87-b5e4-4bfb6e0364a8@aibsd.com>
Date: Mon, 22 Jan 2024 11:48:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: masahiroy@kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
From: Aiden Leong <aiden.leong@aibsd.com>
Subject: Re: [PATCH v2 2/4] modpost: inform compilers that fatal() never
 returns
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


 > The function fatal() never returns because modpost_log() calls exit(1)

 > when LOG_FATAL is passed.
 >
 > Inform compilers of this fact so that unreachable code flow can be
 > identified at compile time.
 >
 > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
 > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
 > ---
 >
 > Changes in v2:
 >   - Use noreturn attribute together with alias
 >
 >  scripts/mod/modpost.c | 3 +++
 >  scripts/mod/modpost.h | 5 ++++-
 >  2 files changed, 7 insertions(+), 1 deletion(-)
 >
 > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
 > index ca0a90158f85..c13bc9095df3 100644
 > --- a/scripts/mod/modpost.c
 > +++ b/scripts/mod/modpost.c
 > @@ -90,6 +90,9 @@ void modpost_log(enum loglevel loglevel, const char 
*fmt, ...)
 >          error_occurred = true;
 >  }
 >
 > +void __attribute__((alias("modpost_log")))

Hi Masahiro,
I cross-compile kernel on Apple Silicon MacBook Pro
and every thing works well until this patch.

My build command:
make ARCH=arm CROSS_COMPILE=arm-none-eabi- \
HOSTCFLAGS="-I/opt/homebrew/opt/openssl/include" \
HOSTLDFLAGS="-L/opt/homebrew/opt/openssl/lib"

Error message:
scripts/mod/modpost.c:93:21: error: aliases are not supported on darwin

Aiden Leong

 > +modpost_log_noret(enum loglevel loglevel, const char *fmt, ...);
 > +
 >  static inline bool strends(const char *str, const char *postfix)
 >  {
 >      if (strlen(str) < strlen(postfix))
 > diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
 > index 9fe974dc1a52..835cababf1b0 100644
 > --- a/scripts/mod/modpost.h
 > +++ b/scripts/mod/modpost.h
 > @@ -200,6 +200,9 @@ enum loglevel {
 >  void __attribute__((format(printf, 2, 3)))
 >  modpost_log(enum loglevel loglevel, const char *fmt, ...);
 >
 > +void __attribute__((format(printf, 2, 3), noreturn))
 > +modpost_log_noret(enum loglevel loglevel, const char *fmt, ...);
 > +
 >  /*
 >   * warn - show the given message, then let modpost continue running, 
still
 >   *        allowing modpost to exit successfully. This should be used 
when
 > @@ -215,4 +218,4 @@ modpost_log(enum loglevel loglevel, const char 
*fmt, ...);
 >   */
 >  #define warn(fmt, args...)    modpost_log(LOG_WARN, fmt, ##args)
 >  #define error(fmt, args...)    modpost_log(LOG_ERROR, fmt, ##args)
 > -#define fatal(fmt, args...)    modpost_log(LOG_FATAL, fmt, ##args)
 > +#define fatal(fmt, args...)    modpost_log_noret(LOG_FATAL, fmt, ##args)
 > --
 > 2.40.1

