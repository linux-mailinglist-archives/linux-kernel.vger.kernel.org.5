Return-Path: <linux-kernel+bounces-25703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD39782D4C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561C6B20E21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4663C5380;
	Mon, 15 Jan 2024 07:58:20 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34122440D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-6c-65a4e5960a1f
Date: Mon, 15 Jan 2024 16:58:09 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: Re: [v4 0/3] Reduce TLB flushes under some specific conditions
Message-ID: <20240115075809.GB56305@system.software.com>
References: <20231109045908.54996-1-byungchul@sk.com>
 <64cb078b-d2e7-417f-8125-b38d423163ce@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cb078b-d2e7-417f-8125-b38d423163ce@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsXC9ZZnke60p0tSDdr+WlrMWb+GzeLzhn9s
	Fp9ePmC0eLGhndHi6/pfzBZPP/WxWFzeNYfN4t6a/6wW53etZbXYsXQfk8WlAwuYLK7vesho
	cbz3AJPF5k1TmS1+/wCqmzPFyuLkrMksDoIe31v7WDwWbCr12LxCy2PxnpdMHptWdbJ5bPo0
	id3j3blz7B4nZvxm8dj50NJj3slAj/f7rrJ5bP1l5/F5k5zHu/lv2QL4orhsUlJzMstSi/Tt
	Ergy9v+uLWhlr5i15SFjA+MR1i5GTg4JAROJuccvMMLY/0+2s4HYLAKqEgf+XGECsdkE1CVu
	3PjJDGKLANmnVi5n72Lk4mAWaGKWuLZ+M9ggYQF3iV2n7oAV8QpYSFydsRusWUggQ+L46zns
	EHFBiZMzn7CA2MwCWhI3/r0EquEAsqUllv/jAAlzCthK7G94BnaDqICyxIFtx5lAdkkIrGOX
	mPLqITPEoZISB1fcYJnAKDALydhZSMbOQhi7gJF5FaNQZl5ZbmJmjoleRmVeZoVecn7uJkZg
	NC6r/RO9g/HTheBDjAIcjEo8vD/+Lk4VYk0sK67MPcQowcGsJMJbfWdJqhBvSmJlVWpRfnxR
	aU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZGeUUOD7bL169ZqfoIm9U3+qSK
	6Oyb9iOsRDpdame0Y9ReF0a2W6/ke+LMLRVfNn7r9ps1mSOSaU++cKC/bl5i1O4ZrkffvwnN
	rpnOGrwpgl+wIfXJ3MtF9/e/Zt/Qdd487aOIUFrFlwcnTtqZxJ2ZPy95peS8H2c+HK5n+v59
	55YfdpPDlospsRRnJBpqMRcVJwIA74qV9MICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsXC5WfdrDvt6ZJUgxvbdSzmrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLA7PPclqcXnXHDaLe2v+s1qc37WW1WLH0n1MFpcOLGCy
	uL7rIaPF8d4DTBabN01ltvj9A6huzhQri5OzJrM4CHl8b+1j8ViwqdRj8wotj8V7XjJ5bFrV
	yeax6dMkdo93586xe5yY8ZvFY+dDS495JwM93u+7yuax+MUHJo+tv+w8Pm+S83g3/y1bAH8U
	l01Kak5mWWqRvl0CV8b+37UFrewVs7Y8ZGxgPMLaxcjJISFgIvH/ZDsbiM0ioCpx4M8VJhCb
	TUBd4saNn8wgtgiQfWrlcvYuRi4OZoEmZolr6zeDNQsLuEvsOnUHrIhXwELi6ozdYM1CAhkS
	x1/PYYeIC0qcnPmEBcRmFtCSuPHvJVANB5AtLbH8HwdImFPAVmJ/wzOwG0QFlCUObDvONIGR
	dxaS7llIumchdC9gZF7FKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGFvLav9M3MH45bL7IUYB
	DkYlHt4ffxenCrEmlhVX5h5ilOBgVhLhrb6zJFWINyWxsiq1KD++qDQntfgQozQHi5I4r1d4
	aoKQQHpiSWp2ampBahFMlomDU6qB0XBH0AqTgptvGY8pH5AIcS8svSnsdeVYv4q8t7q494OV
	LcHPk+TnnXhRqswXef5Lx33Fy1dsNaOVmkWbd6ixXNxae0xzwhWemXzqLHk3vsQtL668kVon
	luWY6vJJYabsrAkKkqdXLNmzXys15v0J64Ps24srfG32p/DPLd3z4lTyurSQT8nxSizFGYmG
	WsxFxYkAiMxD0akCAAA=
X-CFilter-Loop: Reflected

On Thu, Nov 09, 2023 at 06:26:08AM -0800, Dave Hansen wrote:
> On 11/8/23 20:59, Byungchul Park wrote:
> > Can you believe it? I saw the number of TLB full flush reduced about
> > 80% and iTLB miss reduced about 50%, and the time wise performance
> > always shows at least 1% stable improvement with the workload I tested
> > with, XSBench. However, I believe that it would help more with other
> > ones or any real ones. It'd be appreciated to let me know if I'm missing
> > something.
> 
> I see that you've moved a substantial amount of code out of arch/x86.
> That's great.
> 
> But there doesn't appear to be any improvement in the justification or
> performance data.  The page flag is also here, which is horribly frowned
> upon.  It's an absolute no-go with this level of justification.

Okay. I won't use an additional page flag anymore from migrc v5.

Thanks.
	Byungchul

