Return-Path: <linux-kernel+bounces-65787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E5E8551D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EA01C22D70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834B129A69;
	Wed, 14 Feb 2024 18:12:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909A604AB;
	Wed, 14 Feb 2024 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934327; cv=none; b=F5xIdvnyhTDElAuiGmDuqDlwtP8vzJKOK+4yMa1wJ0wytktN5TCyQEcluk3JQuQ14lmJIxX9RaAqIsfMa49fIOeoLM8vrSlklC5HfBXBu4bHXqhGeN6Iv1MCQ0vOyZGp9Ct21WO4qm5BZE+gqIWsJPJH+3/9pggEjVu2UGc/fOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934327; c=relaxed/simple;
	bh=vNYfVpzWs5mAwHw8U9Mt9fK2c5OOucTUa7lfyjm9HwM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3jSwPAqUhhUCtMOqI+y2U8seBNjpj7GzZGNjJEMpqWxCojMfdxhmq8+uO1kCiTxf7IetT5cL9vppY7lJjXGnXBcQSkvP3WMVETRIeZgRAYCpH+a89/Jq5FEWktbCJfR6ZYrXKXtclWifOeeR6pWxcYrNvS9w3PbfR/K9QymbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZmQq1ssPz6K8qR;
	Thu, 15 Feb 2024 02:08:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C3D7F1400CA;
	Thu, 15 Feb 2024 02:12:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 18:12:01 +0000
Date: Wed, 14 Feb 2024 18:12:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, "Smita Koralahalli"
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <20240214181200.0000500b@Huawei.com>
In-Reply-To: <20240214102310.7ba53f3a@gandalf.local.home>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
	<20240214121153.00005c97@huawei.com>
	<20240214102310.7ba53f3a@gandalf.local.home>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Feb 2024 10:23:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 14 Feb 2024 12:11:53 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > So I'm thinking this is a won't fix - wait for the printk rework to land and
> > assume this will be resolved as well?  
> 
> That pretty much sums up what I was about to say ;-)
> 
> tp_printk is more of a hack and not to be used sparingly. With the right
> trace events it can hang the machine.
> 
> So, you can use your internal patch locally, but I would recommend waiting
> for the new printk changes to land. I'm really hoping that will be soon!
> 
> -- Steve

Thanks Steve,

Ira's fix is needed for other valid locking reasons - this was 'just another'
lock debugging report that came up whilst testing it.

For this patch (not a potential additional one that we aren't going to do ;)

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

