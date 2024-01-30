Return-Path: <linux-kernel+bounces-44218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C176841EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEFC1C24860
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389159157;
	Tue, 30 Jan 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GkrVVWPA"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842C58120
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605946; cv=none; b=XAmTqIRBki0Vve1LJ3qisDueD6Vsu51uZfNrPK8W+0H3FSTsjyaTRCGt5QqA1xfTmdyEu0O/CB5kPAz4IfZAtFbJVwnFy4h/Xp1lbA5JmL2RlHj/9HTsQodjzE2ifhZ62fr5i9D9dTtsXrWtjPS0P7N5tLnrWPLlxOshRBOJto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605946; c=relaxed/simple;
	bh=2DIY+lL0JwPloAko6mVPmoNJ4C898Ios+yVnwFsSQws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT6/BXsDXx3Yh0eoLaFCyftJSs/mhlaKXWLS+fKbaqr/7vfhhDwZUP0hZ5M3Hgc2cTuHH5NUicpUJ91jBnLyMq+eHGAUTDsG5wpAyNxVd/BRb88YDzbSoh8mqEPTwAAPqsnadvfvtysJ8/4x0uxUP5u7EYx8WdDLIFWSG3tWaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GkrVVWPA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a35b32bd055so232647666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706605942; x=1707210742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ62OXvXVngPLK5bvC/N3snsj6IMt9f3ZjXYsKK3MQk=;
        b=GkrVVWPAxbFsA5AVK5QorWQHRXNCGAII1WphO9xhgOeLgNvqlYYU/SlMyj4DcHI8eK
         Iz91k83HOd4PeLX7fW6vrWBRRTQul9VlCEUk3z8mQXx1Ooa4MwE9ZgFGpjXZZc+X9BQi
         DFbjmcxxzqCLH0EJlyfWF6xsVIMuaVIqHoylc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605942; x=1707210742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ62OXvXVngPLK5bvC/N3snsj6IMt9f3ZjXYsKK3MQk=;
        b=CEhTT0YLADOHdwWbq87O32xQnbRrBtjBZJFGRLf+a7IqSLJvH/tyViUqCd5l9K5K6l
         ZS6/jWbCPkBsdMj8ukJ6jp2fE/2dx0Oe7HqknEgfpbmwWccpJPBX+PUAFZ1eOj3WxfAa
         qj5EdeKX0pTZmJPTDxtFcuPTwgeeNKEoPfRakrKmjq1pljSAxiCrHNz/VTqc6qFtCIZI
         6Ih6ZouP55jy59SwJ1jqEFsuG6zgeTgTPf2hFMcs7YFgNgPz7HfwfFrssCrzfmvUrH3m
         SOH+5amoHHllL74IQbv8ED52pLMRBS3AJpPzfeWFg206esekCw9IrZYOxCjux2XjLmXR
         tHOQ==
X-Gm-Message-State: AOJu0Yz4Bm0S1Y0csp/N21Bz4jrEdlibyD5JOfj/XeBk/95v0/Ixe7NS
	SQv2w49biZpph5AzCb8MHdI+6agUmh5Ts4YZdLTnicUSoRD3W38W7pvswqBy28zvC27Xh8D40im
	0r0g=
X-Google-Smtp-Source: AGHT+IH7ZE6AUdgRytNb/lhU3D7sQupLz6wV67KxLPeEdmjXL78K1DlcouI/q8OxMGG0LhuA/qXX1Q==
X-Received: by 2002:a17:906:1453:b0:a28:de33:9e6a with SMTP id q19-20020a170906145300b00a28de339e6amr5421904ejc.47.1706605942578;
        Tue, 30 Jan 2024 01:12:22 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id cx8-20020a170907168800b00a358fda40d5sm2709686ejd.140.2024.01.30.01.12.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:12:21 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so84764a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:12:21 -0800 (PST)
X-Received: by 2002:a05:6402:1910:b0:55e:f740:4f39 with SMTP id
 e16-20020a056402191000b0055ef7404f39mr4388911edz.22.1706605941604; Tue, 30
 Jan 2024 01:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com> <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
In-Reply-To: <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 01:12:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
Message-ID: <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 00:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll go back to bed, but I think the fix is something trivial like this:

Almost.

>   +     result = ERR_PTR(ENOENT);

That needs a '-' in front of the ENOENT, otherwise you have a positive
error number and things go wrong very quickly.

And that does indeed fix the lookup problem, but you end up with the
same problem later when you do the eventfs_remove_dir(). Again the
eventfs data structure changes, but we don't have a reliable dentry
that we can invalidate.

The dentry cache is just very good at caching those old dentries, and
the interface for eventfs_create_dir() and eventfs_remove_dir() is
just not great.

If those did an actual path lookup (like eventfs_create_events_dir()
does), we'd have the dentry, and it's trivial to get from dentry to
eventfs_inode.

But going the other way is the broken thing because of how the
dentries are just temporary caches.

I suspect the solution is to make eventfs_create_dir() do the same as
the events directory case does, and actually pin the directory dentry
and save it off.

Oh well. At least I understand what the problem is. Now I'm going to
try to go back to sleep.

              Linus

