Return-Path: <linux-kernel+bounces-59102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C7284F133
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE361F22BA8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932D65BB4;
	Fri,  9 Feb 2024 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiXbhTdo"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A9433D8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465839; cv=none; b=pQ2yMJwnXURUfGmS6V6h20eeAuNmRbnisHZ4OPnrdy8RPwNSPcZ/1pXl0B2eRGTsfiVulBhya7ACLPRXYwISS7OBjjlIN5rQqPTj5OzV5BY7BfgsXwGJY2RTeq22Sm/t+V5yHh3UIpJlSDz3LxJoUgC2BX50IkZ909AT6X9HGSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465839; c=relaxed/simple;
	bh=S9QiHKbRPULgrNB1u3hrSZuExqBXDyzR1rYdu5yRboc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvXIL9BHq9m9DACYCCenZ3WNahA9wVNaTJJX7VdtcCKmkPVQ9jhsmZBz4qBycb3CnlfzJSoMYQWRllwaaq7PQ1lBPlqdEXiCM/fcVmprPTSawJGOeA7OW8Jvgv0nd/a5IHH7zHSOSNYVjc8M6RbYB79xBg5op2QSd/oyWScNjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZiXbhTdo; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-46d1a0c3d3dso136584137.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 00:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707465837; x=1708070637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2U6bB7NjjpmblwYhJ1iAK5ihUXJ4klhQcPAWkvz1K+M=;
        b=ZiXbhTdocJ0/SS/qxt/huTGySgyfC365knTEkLIt7wT/Yo25oRTjRZ5Zg9mHFc3uQ3
         qTjw4SnXzGUAayP8sfUh1Svp4qhY11WRQEmIU+vMDCxRMFl1xF53DHzEdsapRFbCtDny
         JJirNJaC4rT/G8jYmQFc3Lg0oJHXzdkcN6jc7u6Ybo7/IxcYeltIZsAR81Xhd1SVHWWd
         N0la/qsyEm9erqBSCgiba7g9mssoTGUmcjq64L6SfGPwDCXUTTyVegOi1J6sLEUTYgiV
         nCk9It+h01oUZDNK1z5ypD3oNojyILO76f3+DLOAZkIunk0Np4KbeZQyGX64Q3Utoieu
         KAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707465837; x=1708070637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2U6bB7NjjpmblwYhJ1iAK5ihUXJ4klhQcPAWkvz1K+M=;
        b=SwcmcW86prkupdgPu9TqS4K0MQldmAKhccVFMaCwCNesj6e8yzBI4lHZLHj3p2yaX6
         yt0+cB47RtaOmE7vxzhsdSrP/eJAC4oWs0ciiL16bu2KZHrf7kNTjohawYhNz14OuKev
         5Xa9YnPfAsAwIKbZ5r4uHpy7fswFY1E6GuEQM6NEvOesy1KMakJMrjy/Hi+Vh7pXKbuh
         z78P8s/15dEZTdfYuOZroAAbFm5PwTvb6ZaXvr/iwcY5h0XOQilSrkmNEk0oQ3Rp6Dfy
         ZoaPlM5vcimHKWUBr1RyyISPK+kaJNS/4SlFKRFT/mj0CSz+iK2O5FVkGCHAZJxY1Odw
         ybog==
X-Forwarded-Encrypted: i=1; AJvYcCU6gEhEg55/bVe+fIalanC/zMpiOYaUeLpYB45dLXjq39HvCJ4Gb4Vvb9LFjgLbCG6c5ppDP0dIjmngOVfx8uHEUlsMHBSH0reN4Vq8
X-Gm-Message-State: AOJu0Yz9UID89BYIHXEMERCwwVPJgfkL1f5VZwcLzmyoa7WOgTuQ9bRS
	uBL8obXVH4gkATPijmoIdz0mHrxsUywLVa5Vaa+skacbtWQBUozk6/18eokoDyntUKbIVKvCRlC
	P5WWoKndRhJmzTk1nKVDbkQWO0rerCksMfVKw
X-Google-Smtp-Source: AGHT+IEafOeXktUFwoP+T8pWYnrjmDv51yzPE20jXGyGx5mP0Gyq6GaEyED/jB7+4qHAAQ+DwZG1iqiHfkyHp1C9ldY=
X-Received: by 2002:a05:6102:1342:b0:46d:240d:438c with SMTP id
 j2-20020a056102134200b0046d240d438cmr617419vsl.27.1707465837248; Fri, 09 Feb
 2024 00:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208234539.19113-1-osalvador@suse.de>
In-Reply-To: <20240208234539.19113-1-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Fri, 9 Feb 2024 09:03:21 +0100
Message-ID: <CANpmjNOV27EzxfQ1bU_ayKNKt0-FAwjeL9ASK7M2593Z7HvVow@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] page_owner: print stacks and their outstanding allocations
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 00:45, Oscar Salvador <osalvador@suse.de> wrote:
>
> Changes v6 -> v7:
>      - Rebased on top of Andrey Konovalov's libstackdepot patchset
>      - Reformulated the changelogs

Overall looks fine, but I think it's not rebased against the latest
stackdepot version in -next. That version re-introduces variable-sized
records and there's some trickery required so you do not end up with
refcount warnings.

