Return-Path: <linux-kernel+bounces-12680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8395981F8D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A04E1F2435D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445FB8468;
	Thu, 28 Dec 2023 13:23:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97947D2FC;
	Thu, 28 Dec 2023 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dbd87b706aso1105654a34.0;
        Thu, 28 Dec 2023 05:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703769797; x=1704374597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeFP6suxl7EtcK3JyaW9i7TB53KdnNxv2gyZPlwRh+A=;
        b=pxhe1cy4tkXiQOW+dVsmW5xv5XkyzYOQVAI4K0eyTeNV611YyTlyFas6LXco4dMj6M
         efcIucbYGYMY7M7R7bieKtAXdA0/nzB3ziAfnDti4BidXyEgFoy4oqlf7icIOWUdu7c/
         K+HhEnbYc92HFu0NTXd3K4pQJrSYCPyJNKm0vETIM/cwMV+QWNY8LlDDQQPLqs5xsw3i
         LAypSst9178CXLrB3skr7rvHJxOc+GaCWE+PN/QL5SMLnMohLLVDnyQviGnF3njpYXXm
         Y4OEVCUyJX3D6WUAg0YD3BpQmR476WfxGIZ/asoVnIGCXuholPlc2hUrHvExgTxM2UXl
         3tsg==
X-Gm-Message-State: AOJu0YwJiXzpuQWmitbhrjEP8NaAm8FacPcIz/VJualwFtHMDCFcskPA
	PHNxVaD8MJGKrHFMJodcBgS4Map6JVvhBnDkPXW58U8s
X-Google-Smtp-Source: AGHT+IH1B6v2PjfGwNghxpykoryjy3gBaJ41XOQ9spluBAAwXJ9HNHrJD08hiRmGkKFa87NboRKTrPKHmWf/zm/YNXw=
X-Received: by 2002:a05:6820:2e01:b0:594:35b4:8a with SMTP id
 ec1-20020a0568202e0100b0059435b4008amr13760579oob.0.1703769797435; Thu, 28
 Dec 2023 05:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5751163.DvuYhMxLoT@kreacher>
In-Reply-To: <5751163.DvuYhMxLoT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Dec 2023 14:23:06 +0100
Message-ID: <CAJZ5v0gyQ5O-QJEcRJq6pU+Ey6QLiK76SG4hAcQDR_4EPOtX6w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal: core: Fix issues related to thermal zone resume
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Bo Ye <bo.ye@mediatek.com>, 
	Radu Solea <radusolea@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 8:28=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> This patch series fixes some issues related to the suspend and resume of
> thermal zones during system-wide transitions.
>
> Patch [1/3] addresses some existing synchronization issues.
>
> Patch [2/3] is a preliminary change for the last patch.
>
> Patch [3/3] rearranges the thermal zone resume code to resume thermal
> zones asynchronously using the existing thermal zone polling support.
>
> Please refer to the individual patch changelogs for details.

These are fixes, so it would be good to get them into 6.8.

Since I don't see any objections to them, I'm adding them to the
bleeding-edge branch and will move them to linux-next next week.

Thanks!

