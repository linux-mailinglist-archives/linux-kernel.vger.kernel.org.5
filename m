Return-Path: <linux-kernel+bounces-44724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F584268C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E15281E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A16D1CC;
	Tue, 30 Jan 2024 13:59:39 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F886D1AD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623179; cv=none; b=Rj5DhyIt2+fM6J2x713UCf9bnmsd/GkRPQaD99GlCyv9gxyVaYtPHOMHWzzf+Ib+MrcgvnfB5erzojupkaOEAUbiNiW5LaUnwySOXDzoQuM8VWUSva6Y/ivvUfEJ4hBPBJVsF8/1FD81tB5Gdl6EgvL6a5+Vv7Ef4gOE28vi9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623179; c=relaxed/simple;
	bh=CProxbpfby4lnV/hzByBECixIjiFhMLUgDGEQ3lXS2A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DEp7qaXLS0kMLILAuxVzaHJateOxZ2Hnrrv8DFP7fDrDcv/SJpzizAkT06/n0ZN/OViBAt2iY2q6NyEMdDqJGi+Zp38VoaTrCLE28t4a3A/84+qqSudhRBMnIWkX+wJarE20v8xarSZTTIlh9Pqef/0lPvsgRpFZNZzb4P77It8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363824b0968so13728875ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706623177; x=1707227977;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CProxbpfby4lnV/hzByBECixIjiFhMLUgDGEQ3lXS2A=;
        b=QnG1aKH6EtqZ/LutPuJWirqIjeYkxZOq15cCdoY9/X6lLOBL3X319L9n3NfeKK9gV8
         PxaloxidGfq6ZmpeHjWXsy40HBxWGew5Jr+64+dvQMZrEWr4rvcPl0YJBr3UZTz7a1Bk
         PUPUuUKKu32RZsjz+gGe+nXzGw4+SiBMO1Fje9fuRSVql65fE8R/fBodoGXK6vsUjJhC
         0r6oTORmFbQxT11/iACCPVoJ6ytHLR+9H7j83WMke1/titkJDyJG7vUlft45XZQEeNDY
         vUKcsYE6oDi/xCGPwRdV1CSXjIRVJF1s9ZraEeHK4Rp/GTy3R2AYcAS5sARgruXFq1Zv
         IkyQ==
X-Gm-Message-State: AOJu0YyiXpo/TKknfsANALR/5e7p740pJ29ujvGq/o0KpLWGw9RlINR1
	SzZBPhlzgl+YJaRitGzuWlrEk5Vp+YPYX3mQeaT91wrLSYBRa9MO54B/tr0IqhVNJXwajns3CAm
	f0cqYePmJdrl04RrSYG3BKT4xibH+xsDIdOgZqBnIQgfp5qvVpwI9Tl3BKA==
X-Google-Smtp-Source: AGHT+IEj9fp1jvHMNPe8dWChyqtD0OW9MiT5N/e1uUP4exJmqo1iCKfzgS5S7ch+q+G9cQutxPc1CIbp5WzNGun4jStcgc+VDAZq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:35f:c723:1f62 with SMTP id
 r2-20020a92cd82000000b0035fc7231f62mr879801ilb.0.1706623176948; Tue, 30 Jan
 2024 05:59:36 -0800 (PST)
Date: Tue, 30 Jan 2024 05:59:36 -0800
In-Reply-To: <00000000000065fe6705cad8850e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a406406102a2cf2@google.com>
Subject: Re: [syzbot] Re: [syzbot] WARNING in j1939_session_deactivate
From: syzbot <syzbot+535e5aae63c0d0433473@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] WARNING in j1939_session_deactivate
Author: pchelkin@ispras.ru

#syz dup: WARNING in j1939_session_deactivate_activate_next


