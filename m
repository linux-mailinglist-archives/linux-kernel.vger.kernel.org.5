Return-Path: <linux-kernel+bounces-67307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77921856983
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66B2B2A3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCB134739;
	Thu, 15 Feb 2024 16:26:57 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493912AADB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014417; cv=none; b=N3oa8oxo4y4mwiOBLHli4oDBylnTvNi7qSMP/7PV76Vg+0kUNZlb0ujG7eGupO8lZaBRRWuBhl9/EvIAk0MHv5FujDMUiHu7ARXz0gQObHWiXPc42prUn+XsP3Fgb+qvRSJFsGB3kvzadtJxsC+DKL/6wBc4N6XZSTaJPmQeOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014417; c=relaxed/simple;
	bh=H57AIogwBw/N7E+NDITVKpJs665dByAWbGgE4wJb9Ao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tJSEX0NXR8kPLkug9ZgfJyw+OsJp/6pvhPmP8Li6tz7Mec4M5UYeEc2icJ7UPvj/QiWBCQ5qLzqHkE/1YlWyCdiB0CKLB6Pfs1hCXMfeJYUoPOOD5fhfJ414plDWlTufjLNP/JkfdRMBrDDQENpircNV3l43cjWVZwaK+IeWdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363ca646a1dso8907585ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708014415; x=1708619215;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exRGIatqFVrCBLDggD6h6lR/pDl/XmQG8yrLrbfc5VA=;
        b=uFgCr5jpIkigH6FgDrNKEnxl32QwXLYjvih848VwbqJ+f7qIzUN52kWYbXm7MIxDdF
         Jdb+y+DiKjeLzHLkg0yE8mb5sQbVlOHgRVEilo873q67kcNVzU8JdBfSjIzYtMUBefL4
         Vk6GZUBEHUFYiOrErPQUXWY6tSJHt6I6j6IrK+fIsJxNUEYA9OdbQnw+io16i/q9TG04
         GEox3bOGZ/+o29SD0SXEI08NpcCbR/RW9KC4yPflpo4WA1qkEbTDDBDFmhGI2zQ4UHuj
         tDLTPKt1H8Ik8AynWXl+Sjft15uboVvLXcsDCwVTVYfPKCmOq1b1YuXcCdQ95pzz2nTp
         OUvQ==
X-Gm-Message-State: AOJu0YxHr64UBaVYeSQU3EWex5wvpNKSBonTh7TOTxKMJFLvdCKY3feF
	IfAAv/4+WtFrOod9LHRBxUrId2hP14x/NWpn780qDi0ma+yP8QlLRANsLoWAj6kMeCJ53TTjJXj
	tcif13XYENqT0oxGow8iALukNRl5Gmqidq9oGPHB+ZIc+VQCIrTB8iBFiQA==
X-Google-Smtp-Source: AGHT+IEGqaFziUeUTEG2dBSEWYPoRKO4zqGGp5zJbCNmOnNF1EQFCFTj2Y3zejFKODOOdmKzySxMn8N8mjJdNDCzk8Kd3xzhwPgm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3710:b0:363:9176:ca06 with SMTP id
 ck16-20020a056e02371000b003639176ca06mr189388ilb.2.1708014415305; Thu, 15 Feb
 2024 08:26:55 -0800 (PST)
Date: Thu, 15 Feb 2024 08:26:55 -0800
In-Reply-To: <mailman.217.1706634262.2961.pvrusb2@isely.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007eea0a06116e18c6@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+ce750e124675d4599449@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: mazin@getstate.dev

#syz test

