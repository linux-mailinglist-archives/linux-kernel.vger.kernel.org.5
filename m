Return-Path: <linux-kernel+bounces-133258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153DC89A149
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1171C20826
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC72171062;
	Fri,  5 Apr 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hkg4dnxw"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E816F917
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331164; cv=none; b=CvrCtSnwQ0WYKdeYMLpH7VQeqTG0PteBrdzEHnq/By3OQrSPibRSLkd6/M4qpmbV2Y69OcOZQKmLs3pzhS5aeJlfupAiXqoi6SBd7oJOlBOyWSe1cE1ICBubTjIkKyKNYjS/GDaTspCtwbCMfAktuff+apVIolj8OWca7h93Lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331164; c=relaxed/simple;
	bh=5eqSCNEjtJXpk/6DZsrwgHXPlVatBGh6RhudIFZY20o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UegV7LeGrZ0peRl5bqR1UPTKWh/sv6iRLPPRETkPteioKvr7vehLZLr85VTx0iVxz4WBaLMc0xPH0ByE4rJwcPRcfbr4YaVN5Og2P6RRQPqaURvNgIU//pz3Z+N69VXqq/o9Ngf8ufZ71HuGM7LHWEELOzpB0S/lTBFIM6qDtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hkg4dnxw; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-369acec1740so4944905ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712331162; x=1712935962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HBupVq8sRNQ0/e+zQ08oh46OVYn1TgMtv+BrDWwTbo=;
        b=Hkg4dnxwDMCrAOvN8HDCH3ljSRijHRknpzplWblGFJ2GMQw8meOFH92uNGUF4Urhh/
         IJrei5Y7kRlaWhwVatmaDvwNhhkFrr446f4x49yWMfulOu0q8Rme0RhqjitoXM9QoSU4
         kTrVFszhX5PLuaU4AVdGfsgF93skE6FSpxlMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331162; x=1712935962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HBupVq8sRNQ0/e+zQ08oh46OVYn1TgMtv+BrDWwTbo=;
        b=eM9ar+bS+GTfH/QvjBHvtvKXoIzYlB8GIHXoJEyDltEMEFz4QzAjAVF3lwzJkpM7yw
         qZ3kGS3uFA4mBRqdvTRHD6H56aTY5hwmqzLNkDKK7M7bgugxhfe4QcZqf4wrJb1XnxE9
         b17DbX/h5WW70jXKQjBhMJm2FeHzWIZi3gqSoOt/2Axo2k2DA8a5+HYkaLgCGs/SMbOp
         cbKynZkRekM8kvJOMZpxy7T0Zab/mBt/97w2iS6Fh6G6OXJNNBWH0eYO8BfEkjEsMnhL
         ItXKx2SDjdRHHlcGC3MW4H4Z3SKMImW2KC+NsyFikgTyB/EOwb5XD321WYzmt+zJGtC7
         qd8A==
X-Forwarded-Encrypted: i=1; AJvYcCXX3B6om5vI2Eb7We+iAHj3Z6BJdvRDYdd09kir5EA3iCJykPBI3B3wnnUKphQDgrKyeZD4d8S+hjSs21JIdjeVR5wMLzilJO5SvAF6
X-Gm-Message-State: AOJu0YxnvjJvYIv2RHGncbKa24m9aqeLQSJX0p+8Z6rMSBZ+LB7DWTu0
	aMSKUY4U4DKQcvJQVdx4ECOttIj20etBQj055gleTZJ5N8GRLgbnTSn4R6EAcA==
X-Google-Smtp-Source: AGHT+IFAyS5NJbvUgCystqIUFG6PUixCvpV/gat4hk1z7KjiiUWgsTIr7EJgMOjn894eip4sM3zwUw==
X-Received: by 2002:a05:6e02:1d0e:b0:366:89b9:565c with SMTP id i14-20020a056e021d0e00b0036689b9565cmr2174618ila.15.1712331154523;
        Fri, 05 Apr 2024 08:32:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h5-20020a631205000000b005cf450e91d2sm1274954pgl.52.2024.04.05.08.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:32:33 -0700 (PDT)
Date: Fri, 5 Apr 2024 08:32:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 1/2] selftests: Replace "Bail out" with "Error"
Message-ID: <202404050832.35AE5A95@keescook>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <20240405131748.1582646-2-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405131748.1582646-2-usama.anjum@collabora.com>

On Fri, Apr 05, 2024 at 06:17:47PM +0500, Muhammad Usama Anjum wrote:
> "Bail out! " is not descriptive. It rather should be: "Failed: " and
> then that added prefix doesn't need to be added everywhere. Usually in
> the logs, we are searching for "Failed" or "Error" instead of "Bail
> out".
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

