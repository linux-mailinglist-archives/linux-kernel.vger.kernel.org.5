Return-Path: <linux-kernel+bounces-127512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C006894CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF071C21F0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95503C464;
	Tue,  2 Apr 2024 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHRfOE9W"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D018635;
	Tue,  2 Apr 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043492; cv=none; b=UIJVEhAf8XtGZlTb3oZmTIKjMmZg+hZOPm7/qU1ppM3nMsVzSSQUCJjb1BTUuhgqlVqMQgdpZYNZgtCLjaXIF/NvmIRcFDhD1L4z4ne5dYhmn7Pu+cKhXhT7jN9CcpIEEOCpMrp9iFa4FDuMskxhrdGGRlHYmafUcsSF1kNVwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043492; c=relaxed/simple;
	bh=bkEud1DS4CmuqdIWJhXjEm5+cYQ8btjvsByQdn3Q/kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRpydU7zB7/1EZs6WAowa3aI1+vfeRalt/3mJOFXP6hZOVevU51zKOtMGWxiNEYgc2QExvG5AEjg8V3m4raYb/WpSBdCYxlots+/dYvJkYLRJloaij82P7YDT/DmKFC2fh+WwMrNkEc7SDo43FzsUq3y6lMwe6p9Rs1R2313bDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHRfOE9W; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e6db4dfd7aso3609592a34.2;
        Tue, 02 Apr 2024 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712043489; x=1712648289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkEud1DS4CmuqdIWJhXjEm5+cYQ8btjvsByQdn3Q/kw=;
        b=lHRfOE9WTB76EJl99JCYzWTeOcboRSL59u9vO7QpcfNB5TqntwXe8+W0sYnHz6Z9eN
         CPxvc6AKxzHWotYqSqS7Xzio4FPS8YIHX7tRjP22AwjAQpCSL/f+aNGnkKETtg+oCkJA
         r7wzTIxenFsvRl7T/TMidzVnxR/ZYBsg7VHVwWklsC+7viXCcUWfkNszQywRsu11fCWd
         5R9C3+B/WkPJ5eQdtQdU2wcVHIVls842tr6ZBwnUc4rionlV1Itk6P5Zxe+o5kAacGSH
         DPNJYbMvk8hmYctGiNrIORlrqbuFQE+9rwBA5MB3MzOCj6qDxAUeyxSLsCDGoB60APu+
         QI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712043489; x=1712648289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkEud1DS4CmuqdIWJhXjEm5+cYQ8btjvsByQdn3Q/kw=;
        b=LiVoOlyln+kM/4wNDvvYr248J918edZ+PhceVlYRYgN8p7JgyOFYou4XdjkAsnv6RO
         y+J4tFKafJIKV0e2pB3Totj0gQR8OMvJOO3uY7BpBxPSLuWLSOQvdVndR096U5G3adKz
         x5jrz8dpNfcW1A51AxC1qTbVDn12I3l/b0OLr9C5WQAPc0VJY0TWLS567zIqQRFjTw2r
         1js+hdkfiUnfy+m8Fw5quIK3PprtCADN9eRY/WdfiN071ruK32TFDW8z8gOGGuxsv6sK
         VcwgADHB1usd10x7ad/JVGHxv3V21WLemtpx4FH6mGDYOPDo57BUSJ1SySbrXFWVmJDV
         zQIw==
X-Forwarded-Encrypted: i=1; AJvYcCX76yBLszg8CKmWqh+lB9mHOVlLlLw6H8BubrR4IrZK2gEAYIdk3BzyoYbTqKe+4gzmOCDN75MUswsW1i+mxtY072d7Kr8DnZrQhtNjCH4YqbgRi8xdaaoq7lYLGds8PP+xT8lktKKNpb6oCWZZLXC9URoIHL4psJ8iGOcgHr8xLcAuKg==
X-Gm-Message-State: AOJu0Ywv/hdFe0sTIiC30h9t1ailBkBrta4vUtSicGmtUTVlZRbSP0Au
	Yu+Iy9ZYhmTfbHK1ZFj9qWXNDL37ZEgvHuLTbqt1UC+EczhEQ3G3yIR/wQrN7XuwjeePUWOeqpg
	yA6ri9sZX77lWPtuczCBNpms6rlUm3pGi+Io=
X-Google-Smtp-Source: AGHT+IHFLzeDLtGBIrYzgAQS6Hr7ee2/zi63uWsWiVsWTsp8sYSdFbDkTWxYLCjcmaUXCC9pMG2W4IDG6fh2rivYgz8=
X-Received: by 2002:a05:6870:bb12:b0:229:e49f:8dbe with SMTP id
 nw18-20020a056870bb1200b00229e49f8dbemr12661006oab.4.1712043489569; Tue, 02
 Apr 2024 00:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327064354.17384-1-animeshagarwal28@gmail.com> <24c917f6-9ff8-4bca-8cc2-5c14c64c2c9b@kernel.org>
In-Reply-To: <24c917f6-9ff8-4bca-8cc2-5c14c64c2c9b@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Tue, 2 Apr 2024 13:07:58 +0530
Message-ID: <CAE3Oz82qNnUau5JeFBViGYgn4+n988NNFMwg3f8AczVcRVdj8w@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: ata: ahci-da850: Convert to dtschema
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:55=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
> Applied to for-6.10. Thanks !

Thanks for your time Damien.

---
Animesh Agarwal

