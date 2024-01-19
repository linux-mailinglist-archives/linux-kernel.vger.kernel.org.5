Return-Path: <linux-kernel+bounces-31188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3628832A43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEA71F23175
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9777524D7;
	Fri, 19 Jan 2024 13:22:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC902AEE9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670542; cv=none; b=cMZyYHNgp8NtZmGShm1AJr3Rt+TGwNmPsxZKnGSG6zP4j/o4Mo6DwMdV2EORCj5odo/9YF8kgmNFVukZkPP+m0T6QiBGjV66GTyUlcdVw/0CgxsBsfERYXWSczx0vAEdTDPYAYrw6S4/9wgOuLLm1CplOZitOkugyt1nq4QG+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670542; c=relaxed/simple;
	bh=KiUTiAF7Pg3VKwkPX1CJzhmr1upwbLoDhVcg+n8ne6s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P2mh3dY6uzEngFWCscb6EPjTt6CrmXCW+ep5NV4ljCAwrewq4wPGH4E0ixIIayTXH09+VqrWHdOg8z1m9DzKK4FzBGl0QIcs7LLdxXwZrZ3Jrno61/a2r6z++2ofNhbvct+XvH6ik9NmpB4QPn6ZGcjr+uRkwWbQo8o7AGtVW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf178281a5so62584539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705670540; x=1706275340;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiUTiAF7Pg3VKwkPX1CJzhmr1upwbLoDhVcg+n8ne6s=;
        b=V4jZywpuZP/XGFI6pTLiDfgbuPaM/nIHqlpuNW+mIWSbPdzmxJD/3A39mJt1CNBAl3
         pa8FwwDgyEeWFdvkiQn0cNSlA3plV/g+ozpkTJbWcXBq+M4ZXp/Bl6cozKsWRK4B+Kce
         HFjB8BdWxmSLwuQG9SvGtkCfNu759GUcpOlrkl79tyk7/EzASQtJ0kT5+qZJ4NSwnoF1
         NyAymJ+sIE6qf0D5HS4gNq8Y8lN13QDZHyq3yjks0Va8DXYzAq8OqKY3ygky4hjv5fbQ
         o5huOR0d4gvj3elbKaCEAVCpt4BK76gztuMWHopDjDdy/EEEUsHr4ust4bgDU3iHQ6EY
         vNfw==
X-Gm-Message-State: AOJu0YzeUKaMFvlW1UqnjbS6CcS33sd4UaLg90I6uYKep2YxupTAig7b
	nl+lQl5W3dhHGIN5ETGSUMzgQMblc4bd+RcpDkVmHqyenz8D3Z8xnAQolBx0tFjvYR5GmM5oTEV
	4JWcOK2vIaV/qWE5BnMplK6SR/Cx9B3c0GIOGuqwlCUSLENXe+h8mCJlSFQ==
X-Google-Smtp-Source: AGHT+IFaTuiutxjI9lClErARg4ZKJOFq+aLCHOmLBU/lZPQMsdZUAibifC1RvESZnS/AcoXSiOWvIyS8yLy33RJVzDQr+uEwxy5C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:268d:b0:46e:674e:97d8 with SMTP id
 o13-20020a056638268d00b0046e674e97d8mr154259jat.4.1705670540610; Fri, 19 Jan
 2024 05:22:20 -0800 (PST)
Date: Fri, 19 Jan 2024 05:22:20 -0800
In-Reply-To: <000000000000809328060a8a4c1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad5281060f4c5e34@google.com>
Subject: Re: [syzbot] [syzbot] [staging?] [usb?] memory leak in
 _r8712_init_xmit_priv (2)
From: syzbot <syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [staging?] [usb?] memory leak in _r8712_init_xmit_priv (2)
Author: n.zhandarovich@fintech.ru

Test to make sure the issue is still there.

#syz test

