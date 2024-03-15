Return-Path: <linux-kernel+bounces-104741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929E87D2FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23FB1F21769
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994154CB37;
	Fri, 15 Mar 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1YdX/KzY"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2817487A9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524822; cv=none; b=ZHjsw50ju3g1ru0jG1ggw+n1ZR3lAvpTgQfMptg3lAk/sdZIc8p3F4z/F9t9WFpHciA20d70AqG13HvADZ0NIheZCeFd0zjhbgByjL8M+pn3F+p0uPk3l+3Y+RWwtsebp7GWsZTnBJJDFo2qOzWUDAL1uW+jKdragLQlktYoRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524822; c=relaxed/simple;
	bh=/VATxNCGRIQ+t2Yq92hcjSJ1f640xZQiEIYrQi7kJ5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tNiFAmtHIOu3Jjr6/l+jTt7sBq9osY4C9jp4ISQlI9G0XTbWOm/67bZEIHmE5vJgxYX7VYFiyEkBKg1WiHbq2avnSwOloadMuMQ5KGZW6V+m/aTSxngG1Camc86kskqqGgllFaKL0jN6hdylk3OlrGKlE4B6SrlywfkPvG2zUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1YdX/KzY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso1827926a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710524821; x=1711129621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qoOQA6+i8aQ8iwOhf3gL6irab1l/tuoND6d1PwnBTsI=;
        b=1YdX/KzYBPsf96DiZiX1X6W0dpdAXoqK8lIsUbflctSiZmjFgIdPro3Wx8zx0g7Cq2
         wLwqCyndp6ufFkIgNRwVUOivMPYpubc0cxXMJwzIX8bRQMLdGjCSEmPms5/W3Au4SvTE
         rPozzltMszYOeHDP6X119Czx6iRGRi+oomy2Tjkja9uwGis5ORxINrSkAjwc7XB9lBG5
         XttvhcigsrpQMU6nUY8eLWC2eG/OPuN4ycmMduclYO0Le8T6CNBYRDXPANSJb/iiQ6yX
         rulNIy19n/3Edrd7zDMcvfagnmVilwF5aoi2MHMByM8CZhLh68hMyU1LtE+xHcdRNAbw
         IRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710524821; x=1711129621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoOQA6+i8aQ8iwOhf3gL6irab1l/tuoND6d1PwnBTsI=;
        b=FB8FamuzqZ8jIHc4GxJPXP9UoeuIdabB5CTW8n2jTQfT5EHmtTBSncwRazSavHZH6Q
         O89T6/WTV66renHcGKGGuGp9SoAHOr1bjnjsYBTP3fbxev/5/Td+ZTWIKs2NaEzZiUXu
         ascacZXEs5HaWAi5biTJSOesa2QOZpn7E6delFj5sXz4bnvGh5qi/yxSYq7mQ+FO8kBj
         o2tEcC/NjOgDiC64p087j5bO4AOIkTdFSpnAzw6DcCChZRcm5TXrV06DCX9/627NMogR
         AjWIfiaO3KtWf9kyr5hcqXhkPwXrioHrwm9bhcEPuLN+WxrTq8ZH6MA+08im7xBaDKnz
         v22A==
X-Forwarded-Encrypted: i=1; AJvYcCVN90qxR4PvTRBHBm45KgfogwNQwL6/XEoIY+rGwMi76vZPVb4DJ6bg39RjBWLI8sLookFsrfTvHe0d5BNX7Q2J9/srS3d3GABcZ/+i
X-Gm-Message-State: AOJu0Yxd75fZkFQXXpp/emLcYYbpf9iOy8vdY2vtDMLBx31yjj5Bev7b
	RPnw1s5NCMiPuvAxTkJccy712GUVu6lsjjjMVxViu+PN2YsHHetEY9mQzzHYhZPDQQqnc7ewN5u
	qgw==
X-Google-Smtp-Source: AGHT+IEjZSwIQ+dipSKjZhWcaHChKjGlI2nHepHgDdzzp1ICgIQdIah38p9pOvbGYl8oWV2EKIkbRnQvdLg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:e903:0:b0:5dc:4a5f:a5ee with SMTP id
 i3-20020a63e903000000b005dc4a5fa5eemr18686pgh.1.1710524820939; Fri, 15 Mar
 2024 10:47:00 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:46:59 -0700
In-Reply-To: <ZfR4UHsW_Y1xWFF-@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <8f64043a6c393c017347bf8954d92b84b58603ec.1708933498.git.isaku.yamahata@intel.com>
 <e6e8f585-b718-4f53-88f6-89832a1e4b9f@intel.com> <bd21a37560d4d0695425245658a68fcc2a43f0c0.camel@intel.com>
 <54ae3bbb-34dc-4b10-a14e-2af9e9240ef1@intel.com> <ZfR4UHsW_Y1xWFF-@google.com>
Message-ID: <ZfSJkwnC4LRCqQS9@google.com>
Subject: Re: [PATCH v19 007/130] x86/virt/tdx: Export SEAMCALL functions
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	Tina Zhang <tina.zhang@intel.com>, Hang Yuan <hang.yuan@intel.com>, Bo2 Chen <chen.bo@intel.com>, 
	"sagis@google.com" <sagis@google.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	Erdem Aktas <erdemaktas@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 15, 2024, Sean Christopherson wrote:
> So my feedback is to not worry about the exports, and instead focus on figuring
> out a way to make the generated code less bloated and easier to read/debug.

Oh, and please make it a collaborative, public effort.  I don't want to hear
crickets and then see v20 dropped with a completely new SEAMCALL scheme.

