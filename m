Return-Path: <linux-kernel+bounces-152211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE56D8ABAC4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C409B21748
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8773175A9;
	Sat, 20 Apr 2024 09:23:02 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB8171C1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604982; cv=none; b=js/ew7Q+1M5FwAmA/nrRtNodXkngnB4Aq+dNaQV4DumbCbhH9FIs5X6VI/+w7DqleBu3mgr768Oo1fcZD0MN0KLH2/3z4kB7MPCiUJj2A7BXBeVRCo6Xr1INMKzO0oVJPJG8e/tCrFSUvX8GX3KUs8BN0WTTw07Yxp2zyMdfe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604982; c=relaxed/simple;
	bh=HmvUXRk6KWF8pkj/3bMmqxGVWO5zIq4abz7LDPgnwg8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=e3NCxlwnQ5NCs/vqyFa/E5/Rjvukr02NGprOtibIuSRm5/L1yisWnm90vTz9ZNMldSopRVGnGGNtODX/osycxTKbbefrUMR+YGhSmjuNFXUHb9u3U2ktAgrlETfVgIzHWuY9FkmmkTuHNpb2AlEBqmvF8EsdhmgLbKiunVAzV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43K9MsPP050327;
	Sat, 20 Apr 2024 18:22:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sat, 20 Apr 2024 18:22:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43K9MsGg050278
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Apr 2024 18:22:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b07e3771-5599-4abb-b8a7-e8bba72162bb@I-love.SAKURA.ne.jp>
Date: Sat, 20 Apr 2024 18:22:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING: refcount bug in __reset_page_owner
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+98c1a1753a0731df2dd4@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000015b940614004701@google.com>
 <3491cd0a-369c-4827-95b0-eef04bad64e9@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <3491cd0a-369c-4827-95b0-eef04bad64e9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm,page_owner: fix refcount imbalance


