Return-Path: <linux-kernel+bounces-92985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7242872909
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926FF28DD9E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78312C527;
	Tue,  5 Mar 2024 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JfACXXU1"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E312B170
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672463; cv=none; b=Lp4GNsPp+TqHy8liPFzs92LoTj65eixHhIf3BUGN7H2C+gcjKRO16pyVlOftUrE23zoNw6DCDTZQqQo8YXylrvmUMfTKYvuwnMm6BJt9Za7361IfB0Bp2tDDHpSqoOGd+YneWIrPg3GBAuMJN2YtrsIzgQN5XvK3dPdAEG5knnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672463; c=relaxed/simple;
	bh=3mL3z/qxqBUyDlYaBkawRzU+GsgP5u+d/+lOsY1c0J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2FlA/YbH6whKvBJshhv2rDfCq2cG2mj0L58383PG8Q9/XOEaxAXgobFN0gg1Vo6HRROtZRiTLpcj3BtEKwep3IgyC+l8dwo61MKjBOBRXUO14zdL8/qcYM17pmwKIT+NR/+idia2xYqm9XXPRL9NMGzULszrd2+2WyWK2Dnw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JfACXXU1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6de3141f041so4220755b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 13:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709672461; x=1710277261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF432v09KlF629RNN3u5qcmSSQ2n+BPZ5TK5Cfww29c=;
        b=JfACXXU1Z/tJMbfQJ+OKdyimCcXq5lwZiledrnKJ2x0m5WUwbh/MoGI3Ckwdoy8fcR
         VLkIdTu66n93EWSyTzE2ojPS0QZMuT65MimK79Zw8A3wfT+I2u8+7P3/dd4nzD4mcrwk
         DfoyoNPkDVMMveNA7Dmj/oIuzkMfC1n26ApYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672461; x=1710277261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF432v09KlF629RNN3u5qcmSSQ2n+BPZ5TK5Cfww29c=;
        b=BETkkwhRc9S5qRVLSO0HaB6SJDrG+GBrrQrpBs0ZR86gIojoVCMQKUWHAWXt1m6+1J
         WdufPrAtr8PqakOP4X429vFPLClHsQbSSOo+Fii8QBTiMR1MzkSNwvj742sMYqYNaufD
         c6z7vHgSLZ7NckEy7LOgi2QYUEMMoJ5NbU4e3kxRWNN7K0fXYQd7LbCmHQOMtTe7PY3Q
         82lblesJspHdGFBRXjE7UvzIl7CJmXxUD1AyEV28ZzHotoGRBgoOJNygYbPL0kzklLFy
         kwBizZAFgxGPmATXebukGRCIuccrRw8TpnmyQMwyzvFBry4GJ/CHwm4WxBXcw67CXvVS
         ps2g==
X-Forwarded-Encrypted: i=1; AJvYcCUtbuCDwoGKid+TMzOW8x/Y/DNzVfCkhPdNZQUqZyJ70r3mN/sHFzEYXWYkZZLFg3nyJc29+pt+WbHv8ldVuaMLvwGHVjDILfwYTqs+
X-Gm-Message-State: AOJu0YzCjCcodrScu2piA+suKmcrSnZBm6EMrMuQHtvCWNEMETQO1DOi
	/FsG+LYa4Fhzu7AnxyfTFHEFRnuYer/UgYNl7XJ02uuQAYzkTYvtPNgBrj8Pug==
X-Google-Smtp-Source: AGHT+IFgU6Ny/h5rqcqqC1Dq853UHL6pR3leCjAfvblgUgL0FZjcQ559bVzwVH8cdJcz3mW5XsbNzQ==
X-Received: by 2002:a05:6a00:3d10:b0:6e5:a009:9eb4 with SMTP id lo16-20020a056a003d1000b006e5a0099eb4mr15506921pfb.0.1709672459215;
        Tue, 05 Mar 2024 13:00:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b006e530aca55asm9416426pfl.123.2024.03.05.13.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 13:00:58 -0800 (PST)
Date: Tue, 5 Mar 2024 13:00:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [Test Failure Report] exec: Test failures in execveat
Message-ID: <202403051256.7A50FE28E7@keescook>
References: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>

On Tue, Mar 05, 2024 at 07:20:27PM +0500, Muhammad Usama Anjum wrote:
> Hello,
> 
> I've been running execveat (execveat.c) locally on v6.1 and next-20240228.
> It has flaky test case. There are some test cases which fail consistently.
> The comment (not very clear) on top of failing cases is as following:
> 
> /*
>  * Execute as a long pathname relative to "/".  If this is a script,
>  * the interpreter will launch but fail to open the script because its
>  * name ("/dev/fd/5/xxx....") is bigger than PATH_MAX.
>  *
>  * The failure code is usually 127 (POSIX: "If a command is not found,
>  * the exit status shall be 127."), but some systems give 126 (POSIX:
>  * "If the command name is found, but it is not an executable utility,
>  * the exit status shall be 126."), so allow either.
>  */
> The file name is just less than PATH_MAX (4096) and we are expecting the
> execveat() to fail with particular 99 or 127/128 error code. But kernel is
> returning 1 error code. Snippet from full output:
> 
> # child 3493092 exited with 1 not 99 nor 99
> # child 3493094 exited with 1 not 127 nor 126
> 
> I'm not sure if test is wrong or the kernel has changed the return error codes.

The error code is actually coming from the script interpreter (in this
case, "/bin/sh"). On my system, /bin/sh is /bin/dash, and I see the
failure. If I manually change "script" to use "#!/bin/bash", the test
passes for me.

Since lots of other selftests appears to depend on /bin/bash, I think
the right fix is simply:


diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index bf79d664c8e6..0546ca24f2b2 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -393,7 +393,7 @@ static int run_tests(void)
 static void prerequisites(void)
 {
 	int fd;
-	const char *script = "#!/bin/sh\nexit $*\n";
+	const char *script = "#!/bin/bash\nexit $*\n";
 
 	/* Create ephemeral copies of files */
 	exe_cp("execveat", "execveat.ephemeral");


Can you test this and let me know if this fixes it for you?

Thanks for the report!

-Kees

-- 
Kees Cook

