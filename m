Return-Path: <linux-kernel+bounces-16460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1ED823EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6FE1C2131F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3F208CA;
	Thu,  4 Jan 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TUQSBwR8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF43420B05
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso351456a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704361436; x=1704966236; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0k/z1kHRXAj+s1mF7P6s03dINlUIqtFEs2jXJMTBDZI=;
        b=TUQSBwR8sQGT3wnpSJGJv7vtD3ZUmkw/2ryI7R18cYlIxkWWLWcNg0kIXd1AndwIpA
         /3w66Cm8dzkMsOvRVDIc4FAV8Qii7S4Mw5Wy85s5HKP+3wZjKIn5G30uxeyH+QcKQDU8
         DY0a5AETFZd8Xv2xedHXrq+yGRhFtFMN5MH2I7ABUgEk3srNOGzokl2NZmkjoVcRaVbp
         ESL9+CHjVAi6tWnptaofPNLF6gWL1KBVYBmhX+eejCsJubQtyT5NFI8/Z1na30XmKdvg
         X3ScHDtggMQL5jnJWsnlvv6w1yzDio0/Gm2nw1oFgzIR+87Xm03MKO90bH11O0mnnqAN
         13PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704361436; x=1704966236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0k/z1kHRXAj+s1mF7P6s03dINlUIqtFEs2jXJMTBDZI=;
        b=IHF3D7EoooSM3XvFpN/IYFblkrJMhykG5RzcjSLjewlsekKlBZ/H8+xyKLPezRRqjk
         vXPthCz072hsEe92cel9NVM2Bx3HP4PLftbOFYIbI2IBFARFWlAtXsoqzkZa3ib6Lhdd
         i+0dzj4iFlKATrzaXTqMfEJVLDaUfTuUqFf8F/K9/qrDyUjhjm4OtE8WvLDpxbR0OA53
         cfep0Jhme1Cwgp6IPOadjkIlFLGxFpZinGVXEY+NMNMlw45pP8f4ARxl2eGmpqhoAPPE
         hQlB9XQW6rUl/ESALfgy/m2TR2q0HwK4FNQKdVRKLt+uWvp/EC2vhlN5EV7A/5Z/lfPg
         whvQ==
X-Gm-Message-State: AOJu0Yywkg7OFvio972TegpChK+gkU31NEgMik+aLcApLSiVsGYtcR1Y
	iyasP9oSDmYzLCkYcgVQfkkimcqRME5e9A==
X-Google-Smtp-Source: AGHT+IHfVlPtwC/KzQNpaimOtGq2TpUjCqX8fa9Kd9t+GLONYbPV8ozr2kGk6Q0ofmyRvRrjuCLI+A==
X-Received: by 2002:a50:bae4:0:b0:552:39d9:ec4d with SMTP id x91-20020a50bae4000000b0055239d9ec4dmr101781ede.72.1704361436228;
        Thu, 04 Jan 2024 01:43:56 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id r14-20020a056402018e00b00556d13abcc7sm1966617edv.85.2024.01.04.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:43:55 -0800 (PST)
Date: Thu, 4 Jan 2024 10:43:53 +0100
From: Petr Mladek <pmladek@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?utf-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: Suggestion for Capability Check Refinement in
 check_syslog_permissions()
Message-ID: <ZZZ92cjhyr_CgLRJ@alley>
References: <1ee10aa6.d064.18ccdb23971.Coremail.mengjingzi@iie.ac.cn>
 <2024010306-tweezers-skinhead-083e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024010306-tweezers-skinhead-083e@gregkh>

On Wed 2024-01-03 07:59:18, Greg KH wrote:
> On Wed, Jan 03, 2024 at 01:00:58PM +0800, 孟敬姿 wrote:
> > Hi, we suggest revisiting the capability checks in
> > check_syslog_permissions(). Currently CAP_SYSLOG is checked first, and
> > if it’s not there but there is a CAP_SYS_ADMIN, it can also pass the
> > check. We recommend refining this check to exclusively use CAP_SYSLOG.
> > Here's our reasoning for this suggestion:
> 
> Again, have you tested this?

I guess that Meng is right. The current code looks like:

static int check_syslog_permissions(int type, int source)
{
	/*
	 * If this is from /proc/kmsg and we've already opened it, then we've
	 * already done the capabilities checks at open time.
	 */
	if (source == SYSLOG_FROM_PROC && type != SYSLOG_ACTION_OPEN)
		goto ok;

	if (syslog_action_restricted(type)) {
		if (capable(CAP_SYSLOG))
			goto ok;
		/*
		 * For historical reasons, accept CAP_SYS_ADMIN too, with
		 * a warning.
		 */
		if (capable(CAP_SYS_ADMIN)) {
			pr_warn_once("%s (%d): Attempt to access syslog with "
				     "CAP_SYS_ADMIN but no CAP_SYSLOG "
				     "(deprecated).\n",
				 current->comm, task_pid_nr(current));
			goto ok;
		}
		return -EPERM;
	}
ok:
	return security_syslog(type);
}

And CAP_SYS_ADMIN has really been deprecated last 13 years, see the
commit ee24aebffb75a7f940cf ("cap_syslog: accept CAP_SYS_ADMIN for now").

Maybe, it is really time to remove it.

Best Regards,
Petr

