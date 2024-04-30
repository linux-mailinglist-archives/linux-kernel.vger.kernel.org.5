Return-Path: <linux-kernel+bounces-164511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 154DF8B7E70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ECC2B20D24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1DA17F39C;
	Tue, 30 Apr 2024 17:28:43 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335017BB20
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498123; cv=none; b=nOwMdMEBo+oA21ynxljtwDQV0mpoRikcN25Hgm4OeO51auo/r/2JM5SGpOacjQfw4o+Ni2Fz90V4Qo2dNbGgw6cfFV2jyO9X8WkGsMSDxjGGS6ofRKSpWc4b3umAXDL33NnUV22Q47059np0R5LubeUfWb9bKn9ozvNuWw9GGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498123; c=relaxed/simple;
	bh=CXJgUhz8OYEEkYzJZrXQnLGGmaASP98O5B5szOrjNpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aoas4rACw/j+BBYOcG/uYmgYgOqxJGZoMtDlYtt8yn47Hdl2XdhhXdiKEeptQASmUHXi+mOIFv9RWpo7WFj2cBUWMkukEvRzSVJtzbxHt2viHJjp05CKDAqyyzD1qXAPJ0cztxbzAVdVTlBHKi3WVguQQIcW6wp3jL0tmlsbcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ded5e00bf0so203391539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498121; x=1715102921;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXJgUhz8OYEEkYzJZrXQnLGGmaASP98O5B5szOrjNpw=;
        b=wjukC3XQF753ZvJ7rTJ4Qo7yH9+CR2J07aIvkwhuCVGvS1Q0IFHzfqhQgzOR27xsLR
         6m/Vw4N98wFRMz8gKgtR2z/vgdcVLAPQ6R+amWJgfJ9WBagOnLhwLOhHaX0+xDsQzisx
         N6w9UuDr22PC/bE9rBIdp512osv9wX+d4fIR/+hFDJTByUBEkS7P/foyN29LRV0YszSt
         zIkpqzJ6UvVZhIS6t0JzaEJaBQya5ktKvERQJEOEbLRENcXyctI9oHqXwkeiSmyZHCQ4
         YW06l/C6CrhMVfy3KGUEw73o5Cso2AQtvL11DWtaCNiLjePwIJeZeBwNHoGXSUU8cZoq
         UfxQ==
X-Gm-Message-State: AOJu0YzON/9eQFhF1DjWvfA7ccpbSXORqoYP+be5xHRZD72WMk6AffuG
	x90dCf2beFFj+EUnE7ec+7rLYzaYENG0fOSO8XKyslP8+qmV0MIKwSmBQ3h/tFf9jZhCXHomuBy
	VkFHIb33uRIK43c4JhNiLyTtLJdlweT0AtRMRDO3XdhBGaI0FXc0TVHo=
X-Google-Smtp-Source: AGHT+IH5FMmstBBBVzcOx/guNr7Crxo4Pn3rXCcWchG2UxMeNZ0eAyWRA4y4otFoMw+55FnHv1/ciIV8dDcV2RVxGoDiSOSRyAaZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d4:b0:7da:67e8:9379 with SMTP id
 g20-20020a05660226d400b007da67e89379mr13091ioo.4.1714498121387; Tue, 30 Apr
 2024 10:28:41 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:28:41 -0700
In-Reply-To: <000000000000440b0a06173e6ca8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e645b061753b331@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in ext4_inlinedir_to_tree
From: syzbot <syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in ext4_inlinedir_to_tree
Author: shenxiaxi26@gmail.com

#syz test

