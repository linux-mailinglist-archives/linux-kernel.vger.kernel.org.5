Return-Path: <linux-kernel+bounces-99941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1012B878F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B381F22A61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF8E69D08;
	Tue, 12 Mar 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyzqH7Hv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC469979
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230919; cv=none; b=mK4lrw3+b6pJ3bPN54nWqHgvgghWGD7uO++jzB0b3JHoDr1vCTb8w/6v69D7Pf4J6uP0N4PraF25yBITbXTxVbqQ2AA88keWn+Elphn8wwdnhKdqc1yOmGE7piIyfmKdrEWjP6UH3GXJCJzWfrt+PBXoiU3x8495eLlw76bOzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230919; c=relaxed/simple;
	bh=LPn37D0zA4HDuoko8dzIeyqSJ4L8OsaTlUTSJHhe8Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIAVO3kBi8vmMNE4BZqO8JKuamiNPJlMeaniL6PhLO4TNs5jlj3fv+C0dxsObcLt1PIqptxpJw7PfYYFqaE1jIW55IVtJeLFJXFE7lPAL/1acos6O38nkoTfYFeK3dmtdOuQC8XnAw9e3ZQTwzm5QAwEIcxxcpyjqvpUBmaF5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyzqH7Hv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710230916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2/rmYdA4+aZzxntlZRJDjLbuScRrLz7GRFyLSa8T5I=;
	b=OyzqH7HvqfCQCUXiC/90UawpboSZcG1l4wE/byklzccGRZJ41oR3xzZ4qo8KL4cCy6ld5G
	VtBMRr3dhiPbFFiTIVi24tUaQGLTZj4Ix8MDujkas+itu9yB11Jq1A8g04Mr4CPn2R4cBd
	67BCh2iEgAaBPKPg1vG+Nzn4KAyq+8Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-qoGBHRqiOlCQVd9tEgjMPA-1; Tue, 12 Mar 2024 04:08:34 -0400
X-MC-Unique: qoGBHRqiOlCQVd9tEgjMPA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33e97ba772bso1054525f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710230913; x=1710835713;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2/rmYdA4+aZzxntlZRJDjLbuScRrLz7GRFyLSa8T5I=;
        b=m4fwjPczMeJKO9k+XNcRIWsk8Eg1sZrI5cxclxdA+OKUXc0EUR7c3c8Kjc/+lXwfjW
         o83zML1bVBcinCH1xhuUDKHZoYUbajUMXiSWB50NkZYzb/Zc5fBXslSwa2ghcwCiKTy9
         ZcoUWiVqomZb8nhYAZa40I9nHFs0SoUXP1B8x32LLwQcopWOqO+sv+0iac3+2THhp79o
         KM3wn3PzhAFIrk4PtBR82aG3V031euF3nC7OV2npqapFQoo038zo9QClCgoXiq7Ds5ci
         R7/OugBWeBWB+GTSjbGwRSOFyPyqRLkE+UxfFQm4tp7AXO4jlCL9EYUnp3jdMGAaxh4R
         6Nbg==
X-Forwarded-Encrypted: i=1; AJvYcCXpcafY5K5Qs7bRJ3aCARpvTJHTQXJBJGFCrAjeHbjyAi+42fdPrfA8Ni49wCiKhPg70jKCSymRP0YZYCn3OC3QJk9nUsUk7ntOeygT
X-Gm-Message-State: AOJu0YwKM20Zzyjxm7s3rBg/7XdVLxcKiEzVPLU86UfJ+PkdKT03NFzx
	nLF3SGXsoz1+sThJnNyS8xsKxBXQXWsxIA04L9nTqsosGJR7yhKTKGu3pFvBsfW+w9+hRHTJcmq
	hq8PrrU9Zciw/Cbf92OAX0aa9+7FHUwv1fETmto39HTdhppsZudm0eG+eDvg1aw==
X-Received: by 2002:a5d:5012:0:b0:33e:1560:71a8 with SMTP id e18-20020a5d5012000000b0033e156071a8mr6008822wrt.7.1710230913658;
        Tue, 12 Mar 2024 01:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbIvRLSVeeC7KBq7sBGihqLHQXW7BdA0Q6OrHys5PEY/vV9zGL2DS8+VeL3K+WRBa2nrn5HQ==
X-Received: by 2002:a5d:5012:0:b0:33e:1560:71a8 with SMTP id e18-20020a5d5012000000b0033e156071a8mr6008804wrt.7.1710230913293;
        Tue, 12 Mar 2024 01:08:33 -0700 (PDT)
Received: from [10.32.64.131] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d548b000000b0033e3a24f17esm8426405wrv.76.2024.03.12.01.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 01:08:32 -0700 (PDT)
Message-ID: <d0159c8c-f5d8-4731-a820-012702841bfc@redhat.com>
Date: Tue, 12 Mar 2024 09:08:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] rust: str: add {make,to}_{upper,lower}case() to
 CString
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240223163726.12397-1-dakr@redhat.com>
 <6ba16a74-6fa4-4051-8cc6-f0e53a68d8b4@redhat.com>
 <Ze73aPMEg-BUCE8W@hs01.dakr.org>
 <CANiq72kK5CF0RQathACD_=7K1Ye4eMVdUnRcvkDZx4ALtq46wg@mail.gmail.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <CANiq72kK5CF0RQathACD_=7K1Ye4eMVdUnRcvkDZx4ALtq46wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/24 14:10, Miguel Ojeda wrote:
> On Mon, Mar 11, 2024 at 1:22 PM Danilo Krummrich <dakr@redhat.com> wrote:
>>
>> It doesn't seem there's any further feedback, thus can this be merged?
> 
> No, it cannot be applied until the merge window closes, i.e. 2 weeks from now.
> 
> Please note that there are other patches yet to be applied that were
> sent before this v5 -- we aim to send early PRs to Linus, and in
> general for at least a week in -next and for at least a week for
> review. Thus -rc5/6 is already quite late in general.

Thanks for sharing, that sounds all good. Just wanted to know if the
patch was queued up.

- Danilo

> 
> Cheers,
> Miguel
> 


