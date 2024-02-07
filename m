Return-Path: <linux-kernel+bounces-56262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AC084C80A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCF31F21EF2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202FB23777;
	Wed,  7 Feb 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F2LU3Stv"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8B23745
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299690; cv=none; b=YN/To+HY59LAWqEG5ktileziFeeKjH4065V4XnM8z0pWiSIh3FDw9Tsu/9+z0bFXGp98DnI03XvmQjm286LM1OV4RYIPZ7jwvBnYQ3SB/ZyLaUeW8Po4mTedknWV5xAVs2EOnxwnei7jEVdErAWgNqM26jPSS3AiIA1lkBMnoQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299690; c=relaxed/simple;
	bh=gsrPl8ONKkHgMXOtQ3LNXnXN90QVWA2iAnCCffMCo5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TSoK6ezX08f7PkTrJ6D8hkgRAEeIEOZtifrLFt4fZHMosJgBoyLVRnwne9WMuzkg7sYpv0lVwN2xbu2aNQF9xrwE9Z1T5E9VGZ0MrwVdw0TxCqsSdlic6l8KxwMdTJPT5LH8Wp7OGZgExs3VNQoDLGZoQCHntzC7zqhUxmC3td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=F2LU3Stv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3864258438so88368666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707299686; x=1707904486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RHDGnGm44fhHZ7pCs6HugzuCEaAY8Qf8wWUN/+3rMqg=;
        b=F2LU3StvfmH1V+ZOy2mP9Iq5/af1AmYpZG23lOkgKdrDhktZaxdwIfiWlel/wI9PQ+
         nGue4OMcADC0FmywqHfmyM9YhIgy2f+9N8otehqYZtRy0OrXjBCkcVCCp5BfEn5SF0SH
         f846C1jbC0pWLCKqIgGee+lLhbZ5FSlOdQplg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299686; x=1707904486;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHDGnGm44fhHZ7pCs6HugzuCEaAY8Qf8wWUN/+3rMqg=;
        b=OWaw/ZDjPmGeA0X7vCoEkr7JSSBMoxryfjNEyPA5tchN0kdJXKkVNahy/JQbnMHhVE
         Q/zAVlkunW9duJTjYJikyH14VmB2ZbxkL0kkrvZGR8K60mNyZsQ2JFI/7yWdWMzYYTa4
         br99PBlzVdUIrsa/nN1g0/ZXZbs9Gh9FJAqIdUaAJgLNJyQhW3tZh2JtdnTvl4EJDpYL
         nZGWXTv197yehYOUSCQzk8NFGTjMqdg6Q2Wn4giX5f9sLFgqMvFE+4zRamtoL8CozlqX
         vKJujE68zw7QdeO5bTSPA+nhKaIyjaC2ByQUb7loYJYUDjWxzcIWhtiCxCPwwCZEvhtE
         ZVtg==
X-Gm-Message-State: AOJu0YwKwOfvu6pNZxvKR8SzvSIkKZOENBV3oeGUTk/ojfx0orLidMBS
	n4OAzLYluJaEo19aB7wa+rEbGw+sryATcLTESaURcjYAksej7ak0k1T1cfi6/iKhm6W+IKVyl9q
	H+05jcerrXeSncCYRLd+sCyn2MigtggCDJSXD3w==
X-Google-Smtp-Source: AGHT+IF73iv5icu6q3xofIA00A8RhblFD5mtldjebxgQ9NMsDP4GM+4eOq7qYYz289XPnTEvHrKeFaGVIjOPfUuIMzs=
X-Received: by 2002:a17:906:ca58:b0:a38:1712:ef2b with SMTP id
 jx24-20020a170906ca5800b00a381712ef2bmr4496577ejb.21.1707299686008; Wed, 07
 Feb 2024 01:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 Feb 2024 10:54:34 +0100
Message-ID: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] tracing the source of errors
To: lsf-pc <lsf-pc@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[I'm not planning to attend LSF this year, but I thought this topic
might be of interest to those who will.]

The errno thing is really ancient and yet quite usable.  But when
trying to find out where a particular EINVAL is coming from, that's
often mission impossible.

Would it make sense to add infrastructure to allow tracing the source
of errors?  E.g.

strace --errno-trace ls -l foo
..
statx(AT_FDCWD, "foo", ...) = -1 ENOENT [fs/namei.c:1852]
..

Don't know about others, but this issue comes up quite often for me.

I would implement this with macros that record the place where a
particular error has originated, and some way to query the last one
(which wouldn't be 100% accurate, but good enough I guess).

Thanks,
Miklos

