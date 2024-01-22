Return-Path: <linux-kernel+bounces-33840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93943836F59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F391C26FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA95A7A2;
	Mon, 22 Jan 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LjMw9/h/"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE75A78A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945092; cv=none; b=KD/ZbwfwFz+bJiR5CHCyRrk/YA52gPfPdzgYTLMJCPSEW0e7O6gj+bNyigACzFLkS1PwfNUA1IU1w2YGyBZ51kpp0/qErdTdE/9j67VOxuAXge7rBIKCXHk6Em4dfqMdD7v/Lwg0zIpnrTOboJ4GcevNfY3VogBTSNi58gHrpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945092; c=relaxed/simple;
	bh=ORjgQoCGX6sY9TNPJWaMAKB5cO6XOlCarSbw3Ewmkno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/IKHa39Pb2OZ7ikqwDS0dEd7tAHPeecXkAhusJDopLNjP8oBjIDnGRVaaM3VShHchCXGRfQvIFH6fn35tTVscTMDYPdBhKjCdASbCFZcmZypQWB8FeqDo2wq7DxIZMgFDcVIGqev1o1NUNqfJWEWuCUS9Y/hg65Ccb0DWn4VE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LjMw9/h/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55c1ac8d2f2so1825606a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705945088; x=1706549888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bPMaTABmuCocd7Tl83q+z2HLFXNalK+rLT2nyykRvN4=;
        b=LjMw9/h/91S/3sbuO0uxQVTEnquNrIWAuMUjZB2ZPsKBBerKdPk4XH/+VtixmmPUeU
         /iOWSzmPzNiT9gLChmSrpSfcYPMv9enTvvLa+cAAdmh2z7w8PD6ULWl9GOZhXQHfd0uK
         N8O+oNO9J8S8IURju3PR1Z7cYEWXS3IJaCoko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945088; x=1706549888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPMaTABmuCocd7Tl83q+z2HLFXNalK+rLT2nyykRvN4=;
        b=XMK2bK/w3DSYA5HUiRbGjtiGpwBICS9WccbmLK9EdqoSrrMZynO2iZ57mr/sA548Pb
         cEa7th1hS+WE20Ncnlh9knu5JsOjuVtprEoDvI8BwKmietyvT3x5oro+2fWueD6o4iF0
         VKMHLb42GV+M+J0b3Nw1TVJF+OYKT7VWA/3Qp4CP8JZfJcjFgxmHl6jFtkDqkneLDc89
         QYlEBVR1FHha0rP3Is+4BNm0Np2eqsgpT45BUI7/1Wa1uvchzAQlTxzZdhmHBIhgP9/C
         GbGwCwXsSbjuwkksiIHZwJkP8ymhgUzVp+AmBkCR685dTT1kWW1tdPGwW43Va0U0JnXs
         hHIA==
X-Gm-Message-State: AOJu0YwPY57fZ6p9LSJ6Ucb281N5UBMp15dX5VMkqArQhjbZtnlwv5rn
	2JSNcGvkfeqWJ/ru0QJYr1rES1LHtQ4qJ3OkvJHD+sromZi+FA2a4NE4MsjojaXO+gXHi7+48ny
	5jE3jwA==
X-Google-Smtp-Source: AGHT+IE7OTAYAnfdFWTZZXMFPRs3a4E8LOpe+dKpYjUf7TctxxVVz9dO6jg6c+JaX15NMvDmROmU3g==
X-Received: by 2002:a17:906:8a55:b0:a2a:2498:93c5 with SMTP id gx21-20020a1709068a5500b00a2a249893c5mr2129350ejc.73.1705945088544;
        Mon, 22 Jan 2024 09:38:08 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id vk6-20020a170907cbc600b00a2ea02e4162sm7223859ejc.214.2024.01.22.09.38.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:38:07 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55c1ac8d2f2so1825562a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:38:07 -0800 (PST)
X-Received: by 2002:a05:6402:313b:b0:55b:fda0:4f07 with SMTP id
 dd27-20020a056402313b00b0055bfda04f07mr121004edb.9.1705945086903; Mon, 22 Jan
 2024 09:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117143548.595884070@goodmis.org> <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
 <20240122100630.6a400dd3@gandalf.local.home> <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
 <20240122114743.7e46b7cb@gandalf.local.home>
In-Reply-To: <20240122114743.7e46b7cb@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 09:37:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
Message-ID: <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files and
 directories all be the same
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 08:46, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I can add this patch to make sure directory inodes are unique, as it causes
> a regression in find, but keep the file inodes the same.

Yeah, limiting it to directories will at least somewhat help the
address leaking.

However, I also note that you never did the "set i_nlink to one"
trick, which is the traditional thing to do to tell 'find' that it
cannot do its directory optimization thing.

I'm not sure that the nlink trick disables this part of the find
sanity checks, but the *first* thing to check would be something like
this

  --- a/fs/tracefs/inode.c
  +++ b/fs/tracefs/inode.c
  @@ -182,6 +182,7 @@ static int tracefs_getattr(struct mnt_idmap *idmap,

        set_tracefs_inode_owner(inode);
        generic_fillattr(idmap, request_mask, inode, stat);
  +     stat->nlink = 1;
        return 0;
   }

because it might just fix the issue.

Having nlink == 1 is how non-unix filesystems (like FAT etc) indicate
that you can't try to count directory entries to optimize traversal.

And it is possible that that is where the whole find thing comes from,
but who knows, it could be a generic loop detector that runs
independently of the usual link detection.

               Linus

