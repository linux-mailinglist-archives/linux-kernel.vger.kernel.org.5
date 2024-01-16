Return-Path: <linux-kernel+bounces-27480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352682F0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3369928600B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD691BF3B;
	Tue, 16 Jan 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqTc2wzK"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEEB1BF2C;
	Tue, 16 Jan 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2a17f3217aso1091292166b.2;
        Tue, 16 Jan 2024 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705416548; x=1706021348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y02z/tmpib1XgZeXA6m85lQ1dUIeX8FSLuICjkJTAVU=;
        b=NqTc2wzK9kx9nHJQ3yLwoyRBJzhDkvJJ8Se5BdGbEdMtmEU+UxiHAYIMAZkoSEHgHr
         mHF/v2E7e8YgzyIqlkjSq24VfzSKqMhrk6nKkc1SOlpUiBZljbx5FnnQFtDWk5jLLvSD
         +R7c+ESFSbu+dNcJIuB6akoj2NL2ljrMerdEVNeJpl7QLyXpSRnJxXpu4esfYFIyJCrw
         JQqrTF9UbdEjf9ins9MYBIEtiR01rIaJkZt1eW45568dn8YaZtMtbMhd3oT2xXzuCBrk
         IjlfLZZdOB0den01quuqgSxVCYpjWX4/oIWcgRcoCSDbNuleZpvliO5dWXj0alUoI8Nw
         ojaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705416548; x=1706021348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y02z/tmpib1XgZeXA6m85lQ1dUIeX8FSLuICjkJTAVU=;
        b=xPWZlxDiKy2LcNc6bvn2wUss3Rn1AhamkY9eRUDxu1dBp/U8i0t5AAMC0HaZ0XzI3o
         F4OdZkwvhSAwhmaAi6MP44v8A/BwLbSdSiKyrEu6S/++XfZYcWpGPtgLASUpayzKn4Eo
         ABRQLPDSrMvis+emZFazat/MBFpQG1g9gn04eGMdA/eP+jOSNQVhmv4HPWMEF8zDGtsv
         gveaGItww6vevgz3ZcFmhu6v+bwSxocMkMUteYl/xErAXOu4tq9RoI1v4ivuGkAP7M4u
         DEKvzZwsHPbS89W2/ASWYBRJ32PCrR0TUREyOvlrUWPd86c93p9Ilj6jj1P3xobXSKzI
         15ZA==
X-Gm-Message-State: AOJu0YxarN4RbyaGZAXOYjPXWRW7A6H8YzPZfAyC482OPFo0/A4y4JIg
	wP13f9/PsKEFEnPi7tBINbo=
X-Google-Smtp-Source: AGHT+IGC8kIEOXqFqmsUSyhC7Aw8MEjmqXQzeERthvTZRJpSk14GnNKa9UPeMaCllcrNpRJlFaH/Hw==
X-Received: by 2002:a17:907:1b08:b0:a2c:baae:ce1e with SMTP id mp8-20020a1709071b0800b00a2cbaaece1emr4365126ejc.54.1705416548226;
        Tue, 16 Jan 2024 06:49:08 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id tl7-20020a170907c30700b00a2de58581f6sm2273770ejc.74.2024.01.16.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 06:49:07 -0800 (PST)
Date: Tue, 16 Jan 2024 16:49:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: syzbot <syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com>
Cc: andrew@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, lixiaoyan@google.com,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in
 dsa_user_changeupper
Message-ID: <20240116144905.3otl4j3i3xjgzogo@skbuf>
References: <0000000000001d4255060e87545c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001d4255060e87545c@google.com>

On Tue, Jan 09, 2024 at 10:17:34AM -0800, syzbot wrote:
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz fix: net: dsa: fix netdev_priv() dereference before check on non-DSA netdevice events

