Return-Path: <linux-kernel+bounces-59726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894A84FAF7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C8B28CF87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78937EF1B;
	Fri,  9 Feb 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="OJK5+rus"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83887BAF7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499329; cv=none; b=Nb4/GEtYiv4VEajhFthmn9dmlfxUZDQjLDWIVWXN/8NaEXdEBfGUVcE6OIbZxwyR2nEf9+ZlmzBLLoSnQru9fZ7ssHMPqAwaX6m1c1iic0CRWPfgFEzTGFQX3QET/l+xjXFQIZ8RkXAiZr10Q3D5onSPyejeiyzuOopYaC8cBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499329; c=relaxed/simple;
	bh=+imSJtxf176adv1L38bIPJf24ZMDxnz4d3q1WOYyKQE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WY7GvA0DZXzzdjbLxDxBFbqhT4ZxgKIV9uT4myjrqbxP5z9N3aJVM5VNrG5BevrB0T/l1tcYSwUVGTDLQ6+NSzOaZ8sJZJd+V+W4QnkWeoEsk7Vsq96S48sOTBii/njGvekh9Q7Az3lQw/PViRIi1By3N/YwZnJQJPwHBqXZg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=OJK5+rus; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2b05edd46so588243a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1707499326; x=1708104126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+imSJtxf176adv1L38bIPJf24ZMDxnz4d3q1WOYyKQE=;
        b=OJK5+rus6F1AyXivlrEo+gEc6DR3qy/ewI+Q/JirZeMNhhsCsbzsgPX0z3fnFxJJGj
         p6DUFSkcT7jDkIn9AgqVuzK6dMJFnRou4HmFc7038zeuzU2OUiTiYgUWfwMNAnHnAcP4
         jmiaSzL7+S2Pnh0fIA/RD4435x3fGDwHTwWSRY8xYjOasOajzoFpEeHbWTRUSnU0H46i
         TBS+KXGz8EzFKu8UZ7yHzjcfOEJ6upmPUltfS9U6cUgKqd5faWLau9oQSHw1dMMlaP3A
         cufBLUgjATVA/IWXiaa0suzPq7d3vcgPrYBwfZMl12OIcpOSN+P5SKAD8nQ6HNqEIb/X
         7Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707499326; x=1708104126;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+imSJtxf176adv1L38bIPJf24ZMDxnz4d3q1WOYyKQE=;
        b=Pu3aHE9wCNA1CiYvP0gZqBfIkIJwd9YzmYPnKQO7gZ+N7b9TSW7hHarTNkeSliw6Gd
         uI98c5Vjl4pnocOtVWq39Y9ebhA5h5MRMUygFVjalHrysvLFlH95IyfCmItiLNLzRB1r
         WRDzdqQ+ssyopJe7lbqIPjpJEbzoTym2nGUweC95jgrnv4tlg4xKM/wcjpQ8WnZtCzOs
         klvhtvi4SDDHN5cH7zp37SYSzI3HP62e3ZsFWQ0fMoypsGALAckosz2x5geebzKzwb7P
         T090hysU5KbTlXp1EDrm0We7LrocabyxHknNVoRNe7ZgbEfEZCmtbS4ERfJbgKNvgpkq
         6Ucg==
X-Forwarded-Encrypted: i=1; AJvYcCWqWooFH+Toj74NXv9G8fiv18L6KfRLKPdhPaJEcTe8AKWW0939l4006gYbcfXO2uFsFuQWGSOfFlb3A2Ps5UxWMFjXwioUYmG+iZpn
X-Gm-Message-State: AOJu0YxcbAUeguN0LsNPNMIDY/euGQlb+2OwSQcQzDeuxq6pGwICGMa/
	OnqPwvMcnoX36UPfUDrwARrT7wUQtmEx4M1RFLdbXTO0g4m4QqR8pgCnXEXfkmo=
X-Google-Smtp-Source: AGHT+IFVo1pyfJE5nNc0iZXG549RZyZgrMmyUpAXcQcZ48gSLZ324pgrOfBLIZmWlQVqzzGfl7rpPg==
X-Received: by 2002:a9d:4f19:0:b0:6e1:34d7:27b1 with SMTP id d25-20020a9d4f19000000b006e134d727b1mr2335811otl.8.1707499326690;
        Fri, 09 Feb 2024 09:22:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVl6Fpxn1AxKI+k4lodJiIXYHWQhjKKkC3ASjZ65vLhhYopbZD4x09DaxSONhI9f8fNv19KzFGRx1cEyAi+lcYnbk01QarhXSdQvJjFiZPx26YW9yk+m2bEXnvQO4Vm+xdI6xoOLpYg9y3dZKmS0g+tWyYI98LdWAIGjmXB25m2q4OH2vr2FWWl4kPhsyJkPHGQk5GY2NPD9aO4yHNB9FopjPSt0hHOhVTu6ZbduszvYPa6zwzw2mSoTa6oBmPPOg5Cj58vApHjPEYGb09XDfFSoupbxGYjPFBqsnOnzDpYU7Exzl+ppvMd90+W0t6+wu/+oSf8TbAdWO2ru3lhIwHQ6rOZFdGIwc2/cgx7xOA7GnY/DXTXZEglLjYG/e9zCA6Mx5N79QBEUV9dT1wA6Ijj7TEiqofo45d+BB+opNiu0Awrd3f/nin2pvp1FavRnd7Zxa1pdqG1DdGofLxzlk5Hhg==
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id o19-20020ac85553000000b0042a31bc98b9sm860015qtr.24.2024.02.09.09.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:22:04 -0800 (PST)
Message-ID: <49067f872e56d6f315a8b1b93bea92e54cba4874.camel@ndufresne.ca>
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Nishanth Menon <nm@ti.com>, Krzysztof Kozlowski
	 <krzysztof.kozlowski@linaro.org>
Cc: Brandon Brnich <b-brnich@ti.com>, Nas Chung <nas.chung@chipsnmedia.com>,
  Jackson Lee <jackson.lee@chipsnmedia.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, Darren
 Etheridge <detheridge@ti.com>
Date: Fri, 09 Feb 2024 12:22:02 -0500
In-Reply-To: <20240202125257.p4astjuxpzr5ltjs@dragster>
References: <20240201184238.2542695-1-b-brnich@ti.com>
	 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
	 <20240202125257.p4astjuxpzr5ltjs@dragster>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=mQGiBEUQN0MRBACQYceNSezSdMjx7sx6gwKkMghrrODgl3B0eXBTgNp6c431IfOOEsdvkoOh1kwoYcQgbg4MXw6beOltysX4e8fFWsiRkc2nvvRW9ir9kHDm49MkBLqaDjTqOkYKNMiurFW+gozpr/lUW15QqT6v68RYe0zRdtwGZqeLzX2LVuukGwCg4AISzswrrYHNV7vQLcbaUhPgIl0D+gILYT9TJgAEK4YHW+bFRcY+cgUFoLQqQayECMlctKoLOE69nIYOc/hDr9uih1wxrQ/yL0NJvQCohSPyoyLF9b2EuIGhQVp05XP7FzlTxhYvGO/DtO08ec85+bTfVBMV6eeY4MS3ZU+1z7ObD7Pf29YjyTehN2Dan6w1g2rBk5MoA/9nDocSlk4pbFpsYSFmVHsDiAOFje3+iY4ftVDKunKYWMhwRVBjAREOByBagmRau0cLEcElpf4hX5f978GoxSGIsiKoDAlXX+ICDOWC1/EXhEEmBR1gL0QJgiVviNyLfGJlZWnPjw6xhhmtHYWTDxBOP5peztyc2PqeKsLsLWzAr7RDTmljb2xhcyBEdWZyZXNuZSAoQi4gU2MuIEluZm9ybWF0aXF1ZSkgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPohgBBMRAgAgBQJFlCyOAhsDBgsJCAcDAgQVAggDBBYCAwECHgECF4AACgkQcVMCLawGqBwhLQCgzYlrLBj6KIAZ4gmsfjXD6ZtddT8AoIeGDicVq5WvMHNWign6ApQcZUihtElOaWNvbGFzIER1ZnJlc25lIChCLiBTYy4gSW5mb3JtYXRpcXVlKSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY28udWs+iGIEExECACIFAkuzca8CGwMGCwkIBwMCBhUIAgkKCwQWA
 gMBAh4BAheAAAoJEHFTAi2sBqgcQX8An2By6LDEeMxi4B9hUbpvRnzaaeNqA J9Rox8rfqHZnSErw9bCHiBwvwJZ77QxTmljb2xhcyBEdWZyZXNuZSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY29tPohiBBMRAgAiBQJNzZzPAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBxUwItrAaoHLlxAKCYAGf4JL7DYDLs/188CPMGuwLypwCfWKc9DorA9f5pyYlD5pQo6SgSoiC0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPohiBBMRAgAiBQJVwNwgAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBxUwItrAaoHCZ4AJ0QwU6/G4c7h9CkMBT9ZxGLX4KSnQCgq0P7CX7hv/M7HeyfMFZe8t3vAEW0RE5pY29sYXMgRHVmcmVzbmUgKEIuIFNjLiBJbmZvcm1hdGlxdWUpIDxuaWNvbGFzZEBibHVlc3RyZWFrdGVjaC5jb20+iGAEExECACAFAkZjGzoCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRBxUwItrAaoHBl7AJ0d2lrzshMmJaik/EaDEakzEwqgxQCg0JVZMZm9gRfEou1FvinuZxwf/mu0R05pY29sYXMgRHVmcmVzbmUgKEIgU2MuIEluZm9ybWF0aXF1ZSkgPG5pY29sYXMuZHVmcmVzbmVAdXNoZXJicm9va2UuY2E+iGAEExECACAFAkUQN0MCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRBxUwItrAaoHPTnAJ0WGgJJVspoctAvEcI00mtp5WAFGgCgr+E7ItOqZEHAs+xabBgknYZIFPW5Ag0ERRA3UhAIAJ0rxl2HsVg/nSOAUt7U/T/W+RKzVAlD9orCB0pRVvyWNxSr8MHcH
 mWCxykLuB34ouM4GuDVRKfGnqLzJRBfjs7Ax9K2FI3Odund9xpviLCt1jFC0K XL04RebrFT7xjDfocDaSLFvgxMVs/Jr2/ckKPId1oKvgYgt/o+MzUabKyFB8wIvq4GMtj3LoBKLCie2nCaSt7uVUt6q2t5bNWrd3lO6/mWn7YMc5Hsn33H9pS0+9szw6m3dG08eMKNueDlt72QxiYl2rhjzkT4ltKEkFgYBdyrtIj1UO6eX+YXb4E1rCMJrdjBSgqDPK1sWHC7gliy+izr+XTHuFwlfy8gBpsAAwUIAJJNus64gri4HAL632eqVpza83EphX1IuHzLi1LlMnQ9Tm7XKag46NhmJbOByMG33LwBsBdLjjHQSVkYZFWUifq+NWSFC/kqlb72vW8rBAv64+i3QdfxK9FWbweiRsPpvuHjJQuecbPDJpubLaxKbu2aqLCN5LuHXvdQr6KiXwabT+OJ9AJAqHG7q4IEzg4RNUVn9AS6L8bxqMSocjqpWNBCY2efCVd/c6k4Acv6jXu+wDAZEbWXK+71uaUHExhigBYBpiHGrobe32YlTVE/XEIzKKywhm/Hkn5YKWzumLte6xiD9JhKabmD7uqIvLt2twUpz4BdPzj0dvGlSmvFcaaISQQYEQIACQUCRRA3UgIbDAAKCRBxUwItrAaoHJLyAKDeS3AFowM3f1Y3OFU6XRCTKK2ZhwCfT/7P9WDjkkmiq5AfeOiwVlpuHtM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le vendredi 02 f=C3=A9vrier 2024 =C3=A0 06:52 -0600, Nishanth Menon a =C3=
=A9crit=C2=A0:
> On 11:47-20240202, Krzysztof Kozlowski wrote:
> > On 01/02/2024 19:42, Brandon Brnich wrote:
> > > Wave521c has capability to use SRAM carveout to store reference data =
with
> > > purpose of reducing memory bandwidth. To properly use this pool, the =
driver
> > > expects to have an sram and sram-size node. Without sram-size node, d=
river
> > > will default value to zero, making sram node irrelevant.
> >=20
> > I am sorry, but what driver expects should not be rationale for new
> > property. This justification suggests clearly it is not a property for =
DT.
> >=20
>=20
> Yup, the argumentation in the commit message is from the wrong
> perspective. bindings are OS agnostic hardware description, and what
> driver does with the description is driver's problem.
>=20
> I will at least paraphrase my understanding:
> In this case, however, the hardware block will limp along with
> the usage of DDR (as is the current description), due to the
> latencies involved for DDR accesses. However, the hardware block
> has capability to use a substantially lower latency SRAM to provide
> proper performance and hence for example, deal with higher resolution

nit: I'd suggest to refer to "higher bandwidth" to generalize the combinati=
on
formed by resolution and frame rate. The resolution is always fixed with th=
is
IP, regardless if its fast enough of not. It may not match the stream creat=
or
intended frame rate though, which such optimization may fix.

> data streams. This SRAM is instantiated at SoC level rather than
> embedded within the hardware block itself.
>=20
>=20


