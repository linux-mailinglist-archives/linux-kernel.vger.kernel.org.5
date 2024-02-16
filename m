Return-Path: <linux-kernel+bounces-69267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6315085866B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182901F247B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58C137C51;
	Fri, 16 Feb 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhSj6mnz"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01912A158
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113200; cv=none; b=GYgBjUPozxNN0u/6301OEnB5BeAItnd5DGOmpb7Ly0NY8kteF9HD5m5Vk3bev6b2TMkZtfaXLtCWBMexjjZe2Mwf61HCHm4aere8Dy6sxYMECChp94IkXO9pangvquLU1yjMWSjFtUf+fHYzMrqCmw3bNYon3MB1jf8QnVWKd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113200; c=relaxed/simple;
	bh=OyttSQJjlrv3AlcIV7LDU8V2PD0Ubsdm+7yx+NWCqY8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k7ft0A3SNoqcuRopw8PeG8ZnXreRYdoWe+/KFCO3epqH0u8llqyXgTcRlITVePgHqVmnYuXBGUVEYN/sNnMQK3d7oUML+80llefztazwDSD9UR46yv58ErY2gZD3REIm9XI5cM3WH7FrZK0RBuGawMFMZKeAT0+35rrhRyMRbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhSj6mnz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42db1baff53so43751cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708113198; x=1708717998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5B/j3G07gJZvOQOVMzAXdEZwYlWaroSaYmmknHh7xdM=;
        b=mhSj6mnz1uIQzBJMT5fjVL5YXuUovCtZO8lONs7aY4pxzFZ/ALeY4B06yv5O5aImt7
         BCfymhxDQZIhzK6IE6S5d/+SWCIlAv+uQMy+5wKcbgJRWI8nIwukfL4jhY9KsQxHzXl+
         niOva/eXSnvwOIWtRTi1h6jY13Nee3UsQMAN9+G+WexIyrtLtUJwozAwuokrC4AdaX1U
         6O55WAs+LeRQyeCi4kRr8h82yMO7GJXJIUerqvJ6vkhRn9WyrCAlpmAZewAo2EqGuRG4
         P8/Lk6yRANymrsFulBWZ9nheANl6S8r3XtV1G2WV9APa1p6g1ZPY7d917jR1IzRgWuAJ
         46kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708113198; x=1708717998;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5B/j3G07gJZvOQOVMzAXdEZwYlWaroSaYmmknHh7xdM=;
        b=KHb8LtA22bP2jR+tc9YrLQsYDM5ayURFBRVQdi00NSEAefEyDSkLh/b3bHQDrauKTH
         PBLnCHy/2iYlS0bIsaqg+H9S8mquk6iJgvpl+5omYZEqjUQmwcocKPfQO3+c/pvWbcfQ
         Wkj8FP/9qjtAl3CBxj6OqQht15NLDv20aoSwm1v0TazyMklYWvhdi9Ma3qXP/Odf8x7r
         Zo4KwXnxPIrSA2A2k+zdE1lN3gjEl7evdEwaXKXZT2ysMMSuNyv4W5zSPqSJ6bo27hP4
         axV2vQlPWdi5Bck9XKr35JT5n/AxL0dl7/ZrzdlRXyMF41xp2lnl0Li3D5xX/BMaLg0g
         55bg==
X-Gm-Message-State: AOJu0YwZcE0h/fiPZ+zv9c6BrUO1OxK0nD5l9bgJ7zZB/ji4sHx9/QgJ
	G1D97F/3dgKsaEeBrOVZ1renQPw3GZEPGRXuda20d4A3H7spnImB4gP9R1EQv/9dDqFh9arZWpt
	rqeX00gcMkwYSh61UBQNne6CJj4hD/+IRbVLOEssay0B1g97t8Al1
X-Google-Smtp-Source: AGHT+IFCZ0QyDfHSpnEDnApNxB798LSgGfFPzf66h453AgZV5OD63xLTHzQBhwB285VP9CZxKH9l5mH3l+YWR8a+lek=
X-Received: by 2002:ac8:4d8e:0:b0:42d:ec86:6224 with SMTP id
 a14-20020ac84d8e000000b0042dec866224mr31379qtw.15.1708113197866; Fri, 16 Feb
 2024 11:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Lawrence <paullawrence@google.com>
Date: Fri, 16 Feb 2024 11:53:04 -0800
Message-ID: <CAL=UVf5hZNVUPv4WdLsyMw5X8kP-3=gwU9mymWS_3APTVuSacQ@mail.gmail.com>
Subject: Regression: File truncate inotify behavior change
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The change:

fsnotify: move fsnotify_open() hook into do_dentry_open()

has modified notification behavior on creat. Specifically, calling
creat on an existing file used to emit a modify then an open
notification, presumably from the file being truncated first. After
this change, there is no modify. I wrote the following test program:

#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/inotify.h>

const char *dirname = "test";
const char *filename = "test/file";

int main() {
  char buffer[4096];
  int size;
  char *ptr = buffer;

  mkdir(dirname, 0777);
  int nfd = inotify_init();
  inotify_add_watch(nfd, dirname, IN_ALL_EVENTS);
  int fd = creat(filename, 0600);
  write(fd, "hello", 5);
  close(fd);
  size = read(nfd, buffer, sizeof(buffer));

  while(size > 0) {
    struct inotify_event *ie = (struct inotify_event *) ptr;
    printf("%d %u %u %u %s\n", ie->wd, (unsigned) ie->mask, (unsigned)
ie->cookie, (unsigned) ie->len, ie->name);
    ptr += sizeof(*ie) + ie->len;
    size -= sizeof(*ie) + ie->len;
  }

  return 0;
}

which demonstrates the change - if you run it twice without this patch, you get:

debian@debian:~$ ./test
1 256 0 16 file
1 32 0 16 file
1 2 0 16 file
1 8 0 16 file
debian@debian:~$ ./test
1 2 0 16 file
1 32 0 16 file
1 2 0 16 file
1 8 0 16 file

but with this patch you get:

debian@debian:~$ ./test
1 256 0 16 file
1 32 0 16 file
1 2 0 16 file
1 8 0 16 file
debian@debian:~$ ./test
1 32 0 16 file
1 2 0 16 file
1 8 0 16 file

(Android has a CTS test that detected this change in behavior. I am
not aware of any actual breakages caused by it, but it seemed worth
surfacing this change so we can decide the best course of action.)

Paul

