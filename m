Return-Path: <linux-kernel+bounces-156816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705A88B0894
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D68F287F38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0ED15AAAB;
	Wed, 24 Apr 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RldBBxKw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77F15A481;
	Wed, 24 Apr 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959169; cv=none; b=o8+QoRTWiqpJZFHYR4fitkbm99iGoNIsn9kYK0bpirwLmmgD+3L0H1IijignE5smTa+ZA3sssdC11KcTdi+VuNcPuGkP5kAZCMQti8o0KXTzVzjdDCwyQ5hrzSXSHHy3ES5UOYo/4A6u9Nl530fcrWoLq2ik+7O4OloF0PK+OuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959169; c=relaxed/simple;
	bh=5LSW3jPy3YfbIsmSL2DQARdEAzwSgLPdgjo0MkCPNrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bz14fc9yx3mvZDZIXXXnwUopN2DprdTwTueNbwi0vHhDbn5Fim84MjQmG4u0GwRTmGXu0wQDYh1+X7PIjEWMnn3mXDB7CzijzVQQojiMPaU64IPeijO785VBV5Os/3asKnA4VBru4gEZoY8wxMn/S8D+BCu/j0w0fvSu7wNrOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RldBBxKw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b21ed1985so763675e9.3;
        Wed, 24 Apr 2024 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713959166; x=1714563966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAXuJv4h9OIOAMxzqsiwDTfpjlDMAv2iPJrJHbTkVKM=;
        b=RldBBxKw7e0mVXdTsqMPhZz/uqILYHUbeaXYqrQpijQ8B7JUSYFUvKjd+gDEomicRX
         6jY4gBJO512fbsD52HBc4x3VJmKeLJCXOocUpw6pfvz3VqXE533DLOUgXPgkGuy6Y+UZ
         q9wgSwIEJExXpvOPyeC+lHoFBnfaiMS820fDgiZUgbtWvVUt8HliK1KUYTCCy47ZdAx2
         maoxeehRrA05b54YdMrkqZWqhPh3SybqQUXtopmh+tIJm/4JipMxXXFYWR0plRHHa/RM
         KWk3RDlx8YEGnV89guclqG8Gk9Xomj+qhQD7mfX08Uzr53xrVEkkNYdWG2d3eg70gcfS
         IkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959166; x=1714563966;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAXuJv4h9OIOAMxzqsiwDTfpjlDMAv2iPJrJHbTkVKM=;
        b=JKhy5Givk4lkFr7fIOBdpT+gtCJ/19PPwJZW/pfT6HL1g54p03Fcfjuyhf+lOh2frk
         56HYMnWTVPXqPkg7YiF51ZDFVPL0fKJQ2DOQw/8hIkP+v3hy0JLlQHAVz3FJZmcewYQJ
         zI+dej4R0UOcl1bcvl9U4d2EiuHv52gERPjHyUrUDzJd3FjCKEyi1ilJVJlJR9FTIOK+
         Z1zd5xKmrhPfjEhG6KJD44mvwqAZc7pV5Ej+kdkFyHjEYShvc+xL8eUTFGFvFYW+jqvu
         5BwGW/9WOHtdI+R3hnJ6b9lDGpONfLISZ0H8GuEELDIYb4GvVTG/4gk1LUrsCZE9BfbZ
         jGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtewR//rlQu3pYbgVwSkESw/QqWUJElRYq6tYTQavAF4OcjTzraRUklpd+dZTJovbv5RdJE28CP2uNB88+yLZzsU2/jOmUXrs=
X-Gm-Message-State: AOJu0YxJpDEYPBQm4eojDDO8UOo1aLI3i3KjmKOQ8c8fZpKGLwX29DMe
	2fnhz+sBv3f0iMI0dyA9cQ7tu6QrzhVcAVX/x48wbeX9Ivfccm/R
X-Google-Smtp-Source: AGHT+IG1gNFpMsNB+ZWJ9FTRF+wRkrT5lJrFadOThgECa6M8GBYaWHMJFrLMAhjibeVkKi+Z7rmhyw==
X-Received: by 2002:a05:600c:358b:b0:416:6af1:27af with SMTP id p11-20020a05600c358b00b004166af127afmr1579428wmq.35.1713959165820;
        Wed, 24 Apr 2024 04:46:05 -0700 (PDT)
Received: from aquecedor-3-0.lan ([2001:818:e81c:ce00:7193:3bd:90d8:9d8])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c475100b004162d06768bsm27415801wmo.21.2024.04.24.04.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:46:05 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:46:03 +0100
From: =?iso-8859-1?Q?Jos=E9?= Relvas <josemonsantorelvas@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Mark Pearson <mpearson@lenovo.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Evaluate all Low-Power S0 Idle _DSM
 functions
Message-ID: <Zijw-19v7P69tYBm@aquecedor-3-0.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12427214.O9o76ZdvQC@kreacher>

On 4/23/2024 14:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 073237281a50 ("ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT
> UUID for non-AMD systems") attempted to avoid evaluating the same Low-
> Power S0 Idle _DSM functions for different UUIDs, but that turns out to
> be a mistake, because some systems in the field are adversely affected
> by it.
> 
> Address this by allowing  all Low-Power S0 Idle _DSM functions to be
> evaluated, but still print the message regarding duplication of Low-
> Power S0 Idle _DSM function sets for different UUIDs.
> 
> Fixes: 073237281a50 ("ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT UUID for non-AMD systems")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218750
> Reported-and-tested-by: Mark Pearson <mpearson@lenovo.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

FYI, I can confirm that this fixes the regression on my Thinkpad P1 Gen 6.

