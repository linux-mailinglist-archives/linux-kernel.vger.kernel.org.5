Return-Path: <linux-kernel+bounces-34231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D068375FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8271B284865
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A834A9A1;
	Mon, 22 Jan 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPPucPcO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E2495EB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961805; cv=none; b=NQr4CrYsZRU9vWXnoXsENVGd0Vdz4MTbMuEYVjT0EEuOlyye0DN4BOYk+Ct9479AfXKHwxBnSXZGyETGv847RcL8vfnKzZ00U0ATEj6BNHMptLvLiuzE6EV/z1f32BVioBB+G06AZTfMTS+Gv2b/tV5eIGOcv/gMmsRgucVcM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961805; c=relaxed/simple;
	bh=zpHSxyxjqSYyi+Uuf35ROAtNAMm8L1pBJx6LkCld5PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j851OFMYJM5BWQ5UJeZGOA+MxmuhX35XZY5+UL5BNRaHQmw4s2gKlPylZJTgDaiD2o9aJH72pN/tdRRVjUAvBXe7D1yMuQTvbd7mPlLvDliMDpE7F1OapXPiZHs/nf8WLo0s5RZewabi9KNcJPjEVck2E4NHNvxoAcm9N5yF0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPPucPcO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705961803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgrZaLUDZX0rpHph8wYR2fbFPEW3Vfi/WSc3wqW+lkA=;
	b=EPPucPcORYUEPcWGS7qeW/FMGRU9JjXn/RCkOs06sufuTwQCjwoDtJW1cAFJmoEPK5Rr6b
	DasJGYnhF+UoIOmYvBXZTqLpvgcH0bzK0GvuarnEiHabRzE3oVbwENk0Nr0j9A0VAhVEDx
	/KJLl3+mFuSvpP7vrxrFlLmZzAB74Uc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-5qQQxakgOjOhuctDJ01KuA-1; Mon, 22 Jan 2024 17:16:41 -0500
X-MC-Unique: 5qQQxakgOjOhuctDJ01KuA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3367e2bd8b0so2696218f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705961800; x=1706566600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgrZaLUDZX0rpHph8wYR2fbFPEW3Vfi/WSc3wqW+lkA=;
        b=De5WWCc0se9CGdtvtVyMR7d2PqrwKUxSS+jWQvLv0+CLh8fbPsddqoPNWeGxwq1z9V
         ZmJcVOV2kgYyHIQNG6QZXBbZye6rqq0JLe8rY2AwqlvxPJ58nRBHHAnPYPFIJ6v6x0CC
         RZh1qoZcFSvh1GCI+dCdj0Lg8pSXX6ixkYEmjeDGEA85Wsx5ntXUj2rfIZE5a6k1YyOO
         exP4g05dh4ZU23TQuKbgbx0aGPVWm0K1nc557G9S39rzv1WGpgOkpO2AGTfM4vdZpwt8
         SFoZqPiom8nDL2/qMgness8lA616d7GPw4/sfaK4fHBigXEwAiMeP+oBSwwLh0EK7/Gn
         /kUg==
X-Gm-Message-State: AOJu0YxHbzS1sE2B+MRbjzMujp8y5INIAcYjnoePjUAD/9glHVH26CV5
	4x6JOlIqCCcldCAg9kFJLX612+vZedfiGvYqZRN1qhBRLKBDGexq5p5gxSdb45wwdut4mNEb/of
	o3mHr48XQJofFfdy3rKUid4pT7Z3FPGM+4ifbHaH8ozKxq81tgeqVpqOnki810g==
X-Received: by 2002:a5d:448b:0:b0:337:bf4c:3a81 with SMTP id j11-20020a5d448b000000b00337bf4c3a81mr2380774wrq.75.1705961800511;
        Mon, 22 Jan 2024 14:16:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWdH0GMxWI068JJC+LHDgSL52h2kQAYV0P+HNqImIdsOA1ed+Uxg1v1MOWcAqydVLXIXeq+Q==
X-Received: by 2002:a5d:448b:0:b0:337:bf4c:3a81 with SMTP id j11-20020a5d448b000000b00337bf4c3a81mr2380760wrq.75.1705961800201;
        Mon, 22 Jan 2024 14:16:40 -0800 (PST)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d604e000000b003392cdeb3a2sm5703597wrt.103.2024.01.22.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:16:39 -0800 (PST)
Date: Mon, 22 Jan 2024 23:16:37 +0100
From: Danilo Krummrich <dakr@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
Message-ID: <Za7pRc1wTtEhObTN@cassiopeiae>
References: <20240122184608.11863-1-dakr@redhat.com>
 <CANiq72kdX-LK=OurnR5ZGDXEf90DxshUX13up4c8kiz0jxHc+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kdX-LK=OurnR5ZGDXEf90DxshUX13up4c8kiz0jxHc+Q@mail.gmail.com>

On Mon, Jan 22, 2024 at 08:38:26PM +0100, Miguel Ojeda wrote:
> On Mon, Jan 22, 2024 at 7:46 PM Danilo Krummrich <dakr@redhat.com> wrote:
> >
> > Add functions to convert a CString to upper- / lowercase assuming all
> > characters are ASCII encoded.
> 
> Like Alice mentioned, please mention the use case, i.e. the "why?"

Sure, I need this in the context of converting stringified enum values
(representing different GPU chipsets) to strings in order to generate the
corresponding firmware paths. The project context is Nova (GSP only Rust
successor of Nouveau).

If preferred, I can add this to the commit message.

> (perhaps also linking the Zulip discussion if you like [1]).
> 
> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust

Sure, gonna add it.

> 
> > +    /// Converts the whole CString to lowercase.
> 
> Please use Markdown and, if possible, an intra-doc link, i.e.
> 
>     /// Converts the whole [`CString`] to lowercase.
> 
> Also perhaps we should mimic the standard library docs?

Mimic, as in copy them over (to the extent they actually apply)?

> 
> > +    pub fn to_ascii_lowercase(&mut self) {
> > +        self.buf.make_ascii_lowercase();
> > +    }
> 
> Why did you choose the `to_ascii_*()` name for these? In the standard
> library, the in-place ones are `make_ascii_*()` (like the one you call
> in the implementation).

Should be make_ascii_*(), agreed.

> 
> Should the new-object-returned ones be added, by the way, if we are
> adding these?

Sure, I'm fine adding them as well. Not sure we'll need them for Nova though.

- Danilo

> 
> Cheers,
> Miguel
> 


