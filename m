Return-Path: <linux-kernel+bounces-39135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407A83CB47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968CC1C2437E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6A433D4;
	Thu, 25 Jan 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIm1/Fac"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED11BDD6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208006; cv=none; b=J5QSink/oIAmsRXr2tKfu4ZNhdGAjwhMXkZxtx/tNbYig6u/OUOAXvX/rmF8HoH+G4OodXDh4J886wtXQOMVXoycZWnjHZiAaja/hnVRwN6EOMqkFkyi+/26ePVapNBanWMmz0n0S8uJcwiyMYA5RKVO7bXUqFPpNw9fH3DZrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208006; c=relaxed/simple;
	bh=3CLSfBfENYV5XhGFt9BT6JPp3GQDXIfg6Fvv887gOHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNju42Enopnnmo2gfRnSp50lxgo/zDfNiGX81TMz+BgzrfRq8Rf2ygPhhX04LpV9KrAL6QUbZEGeMbonnk0CQKFtjre9n2SltIROGfBoHdyIdWd93srp7o9Hlj/sygJBHbNbnqsPX8dD8ullUlLIbFSJO9SmgLLZ1oR+5cRLC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIm1/Fac; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ec6a002a7so24374215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208003; x=1706812803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijNUk4GYjeMZUPqqpKW/HBBXeKe2nIxIazswVza/uWI=;
        b=cIm1/FacjduA6J7t51hVnNxIeW5+u3kIuIy7XosAt0zR4ZGSrDR8yarvpGvvAPhnpl
         3E4ea9UWj38pAxN+bjyil67eMTzzaz7HNMsyX2exLH+D/15cEQCkt5sOZQdj29Azh9hP
         TJT7w+q2gJVn24uMguoUkb5yddwEs8iu7SMtjqZkiUehbH9QjUao3Qmsl0sttCj+qSCB
         Bgwe9wNZ+vXplSLLojzmd2k+gzYjSL1HUUvxmRT378sR8t0vYaarHW2OqG1aJrK309mx
         mw6Jlelx0v/K1zh+4oxz0YS6hU8SgFPrMye2xbVFwQ2SnPcrPQ/khpkUFlbMfmZlI/Id
         8JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208003; x=1706812803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijNUk4GYjeMZUPqqpKW/HBBXeKe2nIxIazswVza/uWI=;
        b=PsZB/3l4ALjzMU6ZWRBuigO2sDUEt6CWGI0EgyGXrIwuAJ8CvQ0yw/FMTgdD7SGCbs
         TeWOhRUXY+3Noja1gVmkHnL9sVwJwF4FP3p0EvryuKgtvwb3Qg7j9k8/zgyuhf0VG+c4
         3rzaPCpM87EIaZMYaG9v4l9PAq0B+nM7f1ZaAghBGdNLbd8geyIZhdDAQaeJw50Ctw3W
         zvNJ6DuBUhI0WakaAS7+nuHVn3NAbRCW8Az2jtk3I74HycV3FyOBV3emGm8+oZCH3ot+
         XmpM94+Y23sQ1UNWqPsSHAZbeYr8vftSf4iGTis7/fBUE3vVkouNy/xaq5NvHMNJLWxi
         yxew==
X-Gm-Message-State: AOJu0Yzb4XhG7JsU4jXq4rDGEP1FxHPlzcDdsGJKLfzFv8ZdUjQKB7+r
	UQAiCNnyOGNoM1larrXNlPqtWlNTS7gNojUW57q3phma+O+N9tzXPTtsN9vli8NxjfCKRrEtsbH
	Vmkuwl4aUcNcfMaIl51onRtC8lfQ=
X-Google-Smtp-Source: AGHT+IFOTD9p6WHQQNRAhvudCfit2ywt8cabLRMyQged+rfhMS+N3QLgubrBSZkeRsD95lO+cLXJwVGlJodzKOSMljM=
X-Received: by 2002:a05:600c:569a:b0:40e:48aa:c444 with SMTP id
 jt26-20020a05600c569a00b0040e48aac444mr65528wmb.213.1706208002791; Thu, 25
 Jan 2024 10:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125182417.51898-1-jandryuk@gmail.com> <4f5117e3-4dfb-4b37-9ff4-b5f156494d94@intel.com>
In-Reply-To: <4f5117e3-4dfb-4b37-9ff4-b5f156494d94@intel.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Thu, 25 Jan 2024 13:39:51 -0500
Message-ID: <CAKf6xptFyg=pRJAhEg=U2-6rKZVHv3yE4B8P+chcN6AdaK+mig@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/cpa-test: Correct length selection
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:30=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 1/25/24 10:24, Jason Andryuk wrote:
> > The length of pages to modify corresponding to addr[i] is given in
> > len[i].  Remove the hard coded 1.
> >
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> > ---
> > This is a typo, right?  The other cases use len[i].
>
> Sure looks like it to me.
>
> Any idea how this could have gone unnoticed for 5 years?

Not really, which is why I wondered if I was missing something.

Regards,
Jason

