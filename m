Return-Path: <linux-kernel+bounces-91237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98D3870B99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E3E287F50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797C7AE4F;
	Mon,  4 Mar 2024 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCIToB/F"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D535FF0E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584082; cv=none; b=S2NjZXqFCI0CS9KdbM5rx15NZyNciPAG86WnER+gv9xWff8AdaNnNXymOtluIUN9tcnZgz8vcW1l20+S+KgK0khCVnBK16Wwk1cwvMHzfMo7TPD4R6wZ4h1qhyPUdlbedFVSF7iKcRCqOzSGUBRvfDxBMepkDj+w2lbU/8z6BkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584082; c=relaxed/simple;
	bh=8BV7mEbxpQ3N++S3mY+V2k9JTVu8r7BS31hUtho6Ans=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuHEKNbaN42hlldH90pQdB6WU3OY3NTSXZp6m0573f1DpQNPNBubPDUNI/3YNvVxO4GdyQhV/Sy60XbsQ1LuUJpf9qtVFIJVshzQPj1uyqVfH4a3Bwn9QbXmDeJo2u8rwJs6i48sdGI339Yi8i4lmarzIuZp01CLJL2yIJDGM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HCIToB/F; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so17615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709584079; x=1710188879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BV7mEbxpQ3N++S3mY+V2k9JTVu8r7BS31hUtho6Ans=;
        b=HCIToB/FZhH8SLNhH8seFmED9H00rPzjOJrkYx/xG4WcNhGzXGo8sTiZdmSFSFzXUb
         Ia/4CBKYwGpOXqXUvYTKC1LR2V7KU2+YdAhALHybUT66UkHtiqdg27R0KPdsUOlU3Ead
         gzjLaQul/fv6cUjzShvS/H8UZlu4oxvwOuNsbsnoZRsP3sUEr38v4q5xGrfq/sP+Nxbo
         +oGOTJvQpeBQt64s00gQXQGZjlSjTU+/jAWm2H8VVoU/d+BiCZTZW2r55qORsx9sjYYI
         iZBzzspEoWOyWtq/7pWX5yT8NSSXbpK7ayvrHplZ5pOK+3RJWm3XrI6RgR93BXNruOJP
         3I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584079; x=1710188879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BV7mEbxpQ3N++S3mY+V2k9JTVu8r7BS31hUtho6Ans=;
        b=Ww0Pg+wUm7ljsQHocmL5AMbqz2gJa2h9I1tLcpZZIs2TGJz7zdbzpvLnoUZYeszrbT
         cqxc+CotQ7XceCOVcGoCfC5NHzSLEPz4XcrWigrrCL6iJYN0B4o48f9JjI8uu/nGeJHt
         yfttX00U6LuvmOLMbfbJX9OoobDWRW9DkWG3B19M4tdJMz/87wOaXxwezi8vCKzSBRde
         kE8oCzKM2o4jgL6IvUyvbFhChgyCOu0a8eEB/Sd+6oSew+DhAsWSE3ioEuRt5bG/8Xhx
         W7jqyhq+8KHe9j1yOFD1oTl9YTYbKreWrYGY3SdcW6GVQ6J6vBCM5i5/A2xKyG+GgXDI
         Qkww==
X-Gm-Message-State: AOJu0YxrAa6PZoNpp8Xyj8Xnous6yxZJ15kbObvI6e/Dn/z1C3j3T1Ng
	Lfrza0sniodG2Rt+dbTxt2YlNJI5d9kO7r7C0oGIY6fdhDIhuKT/jQ1s1/QZmH/SUjMTFGn3sj/
	EZcwQz8GQJC3K7B71stn8NsW68f2MfYtT4dw=
X-Google-Smtp-Source: AGHT+IFdipdDLYllu2rLBaMDcqB8B9T+KTxthawpJhJ6k/YKp8BeMCQCjv2B1xdctIBPxZgV7sHAlBJ93G6vjWZgciA=
X-Received: by 2002:a1c:7918:0:b0:412:c931:299f with SMTP id
 l24-20020a1c7918000000b00412c931299fmr11954wme.2.1709584079525; Mon, 04 Mar
 2024 12:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304180829.1201726-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240304180829.1201726-1-andriy.shevchenko@linux.intel.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 4 Mar 2024 12:27:47 -0800
Message-ID: <CANDhNCo4BGkFvFz2ZRftvfvY=izjWF7_MP4xFDSwOA1LwCF4Vg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] misc: hisi_hikey_usb: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:08=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Untested, but looks ok to me.

Acked-by: John Stultz <jstultz@google.com>

