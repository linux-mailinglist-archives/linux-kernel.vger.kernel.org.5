Return-Path: <linux-kernel+bounces-98649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284FD877D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA3A1F21EED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1E1CD1C;
	Mon, 11 Mar 2024 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXmn2+wZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF118658
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150597; cv=none; b=hgPxL0nxbbQ133/LEvbmm2VRRQvUMOOf/PJ82aPEKISJxS97RxsxRHaUMVw1Z80D5f0clYbUjMxApVqrP3C/L0y6YsmRyJjVpf65jpe77BI6+zArCUhov14iZD8JbDqlYNLZqEa7yb+kH4tlq//kz8T2fe+etuahoalZdqmugbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150597; c=relaxed/simple;
	bh=AToYTf+vDn2ZCE/0NLRzCVPVI2xnwx7R0rBGKkMz5O8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UVOK/XszRZDbBCFxbNtZMM0P6o2J5PVchtnDSN8cuN7LsjiXnQbN8sm89rxQmlRQ5ya4Fiz+060O++zSIrSEzdNkkV5NYqktYYRziWc/cKEIWVyonz6fhhk+ENewDXKlgVQKT2gwtDinhY8sMkZBP57EzEUV632PY2R/OxkeEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXmn2+wZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0a5bf550so45515197b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710150594; x=1710755394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81noNCiMPxc7RXsxTs6R3a4olVVx7LQELUcM8AsXs8I=;
        b=DXmn2+wZ2J1o8Fb+f6BGl/hzkXdgp378FQ0n7dsounKQILrPkAe0HM5vHfke2JCxTe
         +8Iqzqi0Mw7Qv6m1WsW2oRwk4o34zcSqtZl/i8QVhe6PxZqf84cl9FUvSBrA9ZV2YjkM
         i7eZvzvGdxGjEZJCm4o3J789ejOHsZ37b3mHKfAMFi7yJcXQkJ/Wjd50b1pnNSEzfARw
         Jud+NEinq2nIJbOJXr+X9F9dum7I26CgqYyQip7H913QoivAXfFUfs2PmkqeRAuBO+UJ
         y6HblrAbOAxulwVoVWvusV4NHlnx+GZRT8F6FYzkAFfkjZiUDK8d1s7V5AsVZ5xcNPwc
         fDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710150594; x=1710755394;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81noNCiMPxc7RXsxTs6R3a4olVVx7LQELUcM8AsXs8I=;
        b=KcrYglOR76pUB/tBYXclnWbUaG7dUw9E8rgjHTWGXVErqwNUmFtN+QNMsjBn4BbX3i
         n+5woIFVm9/L71evjaMxdsfUf0eONMwGr5kwk3Of7vTK431duHuNnFcPGlHvr/XxSUsj
         qU9krSiAICjjQ0Ibt7pCKsygZ+wD+Wvbr0tzyuUbZWCsQWdEeKm/km5g+QKCb78G2SMe
         /aTEhDJoHtoFRpM8u+lpmEzxv/sH8Je/scpRkKGip0TEj966oEs6e3NgwBlShkllc52p
         LkaWUP5I0w3NBqLM0iKul87IvaTlVvsogY7WH+LNAeyDEErYOZtyG5ft+BVXy56H89eW
         CGxg==
X-Gm-Message-State: AOJu0YzzB9w+8KU9B2nRzEG3PeSudNiBF/+JHHASYC9iE56sAyx+9f/z
	qJd1z8QQD2nimedG18Zc7juzdyJCHgts1zhkXO+8tKPA6YifYpcstjbbHa6O2EDeeo3BSG6nDqh
	iqrh+8WQBOw7W+g==
X-Google-Smtp-Source: AGHT+IFYFQpiOp2C90LA0H4wOyWDbp4XswPBvjOI48ZxhaXXUEmFbQzr+aoAdPr6DHMiXATByGHh6HKfyGHsCAM=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a0d:dd04:0:b0:60a:25ce:c165 with SMTP id
 g4-20020a0ddd04000000b0060a25cec165mr1150328ywe.6.1710150594639; Mon, 11 Mar
 2024 02:49:54 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:49:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311094947.3738200-1-howardyen@google.com>
Subject: [PATCH v5 0/2] Add support for multiple coherent memory regions
From: Howard Yen <howardyen@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	iommu@lists.linux.dev, Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

In the system I'm working on, there is an always-on subsystem which
includes a small size memory, and several functions need to run and
occupy the memory from the small memory if they need to run on the
always-on subsystem. These functions must allocate the memory from the
small memory region, so that they can get benefit from the always-on
subsystem. So the small memory is split for multiple functions which are
satisfied with their generic use cases. But in specific use cases, like
USB3 devices which support the stream trasnsfer or multiple devices
connect to the host, they required more memory than their pre-allocated
memory region. I tried to implement it in a generic way and propose this
patch to give it the ability to get the memory from the other larger
memory to solve the issue.


Changelog
--------------------------------------------
Changes in v5:
- Fix build break.
- Use of_property_count_u32_elems() instead of
  of_property_count_elems_of_size().

Changes in v4:
- Add the driver where uses the multiple coherent memory regions.

Changes in v3:
- Re-org the members of struct dma_coherent_mem to avoid additional
  pointer arithmetics and the holes inside the structure.
- Use consistent naming of return value.
- Re-write the dev checking statement to be more clear.

Changes in v2:
- Replace the pointer(dma_mem) to a list_head(dma_mems) in the device
  structure and initialize the list_head in device_initialize().
- Modify the required changes in coherent.c.


Howard Yen (2):
  dma-coherent: add support for multi coherent rmems per dev
  usb: host: xhci-plat: add support for multi memory regions

 drivers/base/core.c          |  3 ++
 drivers/usb/host/xhci-plat.c | 19 +++++++-
 include/linux/device.h       |  5 +-
 kernel/dma/coherent.c        | 92 +++++++++++++++++++++++-------------
 4 files changed, 82 insertions(+), 37 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


