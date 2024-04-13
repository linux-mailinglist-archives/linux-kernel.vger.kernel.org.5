Return-Path: <linux-kernel+bounces-143847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE75B8A3E28
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F0E1C20B25
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B804253E0E;
	Sat, 13 Apr 2024 18:58:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE123BE
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713034684; cv=none; b=mQzfbZrIXWCUqx5NBrrdhHq5leGapB3VhHWjwcow7vc5m+MHTwXbx25jnb1CnQ6IHqJt7Yn+CeUWlOHRcZza0BauwxK44hNKr15HTl7elge6vCUvuBFYE4Yq+9ZzhsvsDUup4kpzEVoTG2WqC+GcR909jd9SbsUp4CFo08DAnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713034684; c=relaxed/simple;
	bh=Z7rkWaoilTd9tmdvpoDnzimfRWXUgQN46Zbfj/i3shg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Xn0FfHsfYU0SDrnc2ZcxRU/BFHh2/QM1I3gJeLBYBrpSwf1E2MIUSkt6xQpBPHKRCPmO5yeUmjRLoAudgndYNhcv6Ld6KWEqZmNcs3ENaa6JA+at/G6NET/RFsvVfIV6/wFWI5cuDacSyQsT/KF1ukZkJVFYE9wKdcVuSxD5cc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a0d85da1cso22400605ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 11:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713034682; x=1713639482;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7rkWaoilTd9tmdvpoDnzimfRWXUgQN46Zbfj/i3shg=;
        b=lw6OjfY7YpT939UCg/RYNdkVCVEgFhbgzLM2Gco10T1c6VBWUBYJYVoYdO36YVydRR
         Y8H3q5dTbw0wLT54x8MHhTiuXDl25ty3vwMvbio/1u6GvXMQFhDaM++NOeDFRmTdnE+e
         ZSd9ZDp5j5H/nX9pcj7afqoXQtrDq86sqx+Zcx6zrhtaz7RiLAyU6Of3KGeM8ZYq9CvL
         atwzF1G451DCSEip43ODEqRbDjf0xMFXBY5IbqKe1z+dP9U7evb/OZI2bSJ7cE7azqH9
         dwqvLspQJUZnf2Ar4MUEI8jKedj6SGTUUR4WkEn5U5maYuTIiVXZFZQ5hX3PCkzaKk8E
         II5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbGNNmL9GqnU+4OyixiaToQAfOLyrPV9gb9o1MjADft73gMx/Dqy5T7KvYfoDumLM0+P45/0G8r85lcT7exaBveemihb9dhz6L4zik
X-Gm-Message-State: AOJu0Ywu9lnFJOI+PQ8AN0Cht6HIGhz84H+DBCyrWoXW62eIISV86kM9
	FtW0ll/BVWG7r/QvLJtUCGicf3wPrMUP8HmC0mFCXM3mihvOUvYB5tbiKVkbp2zenu1ua63gkzz
	2uJVA/4abRHMaqtYF4EwDHnd8sJumLYEfv9q5lb8BPp5yS/aZAQ02n6A=
X-Google-Smtp-Source: AGHT+IHfdSWXMNIpkvPfWpjdvQqtBOPBtJz42HPUYlgLhnvPeO1/Cam0byC4OszDtLSAqJbenw3j4CGUB89oWkVrTgkLLZQ2PiO3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26f:0:b0:36a:1b88:910a with SMTP id
 h15-20020a92c26f000000b0036a1b88910amr413352ild.1.1713034682413; Sat, 13 Apr
 2024 11:58:02 -0700 (PDT)
Date: Sat, 13 Apr 2024 11:58:02 -0700
In-Reply-To: <CAE8VWiJ=3VdkVREik2PjX54wSVVRGxVwyjsi5pqkCWByNW0VBA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbc83a0615fef789@google.com>
Subject: Re: mm: page_alloc: Fix uninitialised variable in hfs_revalidate_dentry
From: syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To: shresthprasad7@gmail.com
Cc: shresthprasad7@gmail.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz fix

no commit title


