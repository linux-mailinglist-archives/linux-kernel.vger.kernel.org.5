Return-Path: <linux-kernel+bounces-18478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51213825E31
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CB7284FE3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4B187F;
	Sat,  6 Jan 2024 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M24gs8nG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718B17E1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704515138; x=1736051138;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=K1pFfrfdo49D8TOTL//jcobRos+2Vcr3hksOB7Gvjc8=;
  b=M24gs8nGim641V7jIMeLiHWgYyPhMz/q79sdE/hpT1iWWkDjD0o72FQt
   qnYng/9f0ABkOlchxZGRS7eTStLUMAfsPhtmT5QkffK/fxtr3LdML6Z/C
   /CLfPxEHzICFDPfRcnkILmscQbLirDutO0WhBA6CFubZLH0qYR30vJ6eB
   Iztmgacj6SinsFr7Fzs3QcPQBpueMRk64dzBhccAkyHTNEO4UtvOO5aSK
   NufRqXEmdJkWzVTdnshz4rIZ5iew2BJdXJ6Za0O3iaptNczGtGr7Gyp/P
   W0T5AuupkBZXA9Ru0zDJVhaUMWRP5tQLBm49cPhcPT5Tjy6KzMvEkmGGb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="464035040"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="464035040"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 20:25:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="23022493"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.16.94]) ([10.93.16.94])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 20:25:37 -0800
Message-ID: <b913d3d5-cac6-4713-8590-2c56ad7c69ee@linux.intel.com>
Date: Sat, 6 Jan 2024 12:25:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] [iommu/iova] iova_rbtree_lock contended seriously
 causing performance bottleneck (bisect done; commit found)
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20240103045506.1077586-1-haifeng.zhao@linux.intel.com>
 <fdf1c2b8-6f8a-4f3c-b063-0211fe688121@linux.intel.com>
In-Reply-To: <fdf1c2b8-6f8a-4f3c-b063-0211fe688121@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/3/2024 12:57 PM, Ethan Zhao wrote:
>
> On 1/3/2024 12:55 PM, Ethan Zhao wrote:
> part of the mail got lost after sent
> past here
>
> Issue:
> When network throughput is large (>1GB/s), the performance of
> application nginx hits bottleneck, most of cpu cycles are cost
> by spin lock, it takes a lot of cycles to aquire iova_rbtree_lock
> for  __alloc_and_insert_iova_range().
>> flame graph
>>
>>
>> queued_spin_lock_slowpath-------------\
>> do_raw_spin_lock                       \
>> _raw_spin_lock_irqsave                  \
>> __alloc_and_insert_iova_range            \
>> alloc_iova_fast                           \
>> iommu_dma_alloc_iova                       \
>> __iommu_dma_map                             \
>> iommu_dma_map_page                           \
>> ice_tx_map.isra.0                             \
>> ice_xmit_frame_ring                            \
>> dev_hard_start_xmit                             \
>> sch_direct_xmit                                  \
>> __dev_xmit_skb                                    \
>> __dev_queue_xmit                                   \
>> ip_finish_output2                                   \
>> __ip_queue_xmit                                     \
>> __tcp_transmit_skb                                   \
>> tcp_write_xmit                                       \
>> __tcp_push_pending_frames                             \
>> tcp_sendmsg_locked                                     \
>> tcp_sendmsg                                             \
>> tcp_sendmsg                                              \
>> sock_write_iter                                           \
>> do_iter_readv_writev                                       \
>> do_iter_write                                               \
>> vfs_writev                                                   \
>> do_writev                                                     \
>> do_syscall_64                                                 \
>> entry_SYSCALL_64_after_hwframe                                 \
>> __GI___writev \
>> [nginx] \
>> ngx_linux_sendfile_chain \
>> ngx_http_write_filter \
>> ngx_output_chain \
>> ngx_http_send_response \
>> ngx_http_script_return_code \
>> [nginx] \
>> ngx_http_core_run_phases \
>> ngx_http_process_request \
>>
>> Setup:
>> 1. configure server nginx with following nginx.conf (appended to the 
>> tail)
>>
>> 2. request server with WRK
>>     ./wrk -t 64 -c 1024 -d 40 --latency http://$server_ip:10802/1KB.json
>>
>> Debugging summary:
>>   Bisect identified "commit 371d7955e310 iommu/iova: Improve restart 
>> logic"
>>   as cause.
>>
>> nginx.conf
>> user nginx;
>> worker_processes 16;
>> error_log /var/log/nginx/error.log crit;
>> pid /var/run/nginx.pid;
>> events {
>> worker_connections 4000;
>> use epoll;
>> multi_accept on;
>> }
>> http {
>> include /etc/nginx/mime.types;
>> default_type application/octet-stream;
>> log_format main '$remote_addr - $remote_user [$time_local] "$request" '
>>         '$status $body_bytes_sent "$http_referer" '
>>         '"$http_user_agent" "$http_x_forwarded_for"';
>> access_log off;
>> sendfile on;
>> tcp_nopush on;
>> tcp_nodelay on;
>> keepalive_timeout 65;
>> keepalive_requests 20480;
>> gzip_min_length 10240;
>> gzip_comp_level 1;
>> gzip_vary on;
>> gzip_disable msie6;
>> gzip_proxied expired no-cache no-store private auth;
>> gzip_types
>> # text/html is always compressed by HttpGzipModule
>>     text/css
>>     text/javascript
>>     text/xml
>>     text/plain
>>     text/x-component
>>     application/javascript
>>     application/x-javascript
>>     application/json
>>     application/xml
>>     application/rss+xml
>>     application/atom+xml
>>     font/truetype
>>     font/opentype
>>     application/vnd.ms-fontobject
>>     image/svg+xml;
>>
>> reset_timedout_connection on;
>> client_body_timeout 10;
>> send_timeout 2;
>> include /etc/nginx/conf.d/*.conf;
>> server {
>>     listen 10802;
>>      server_name  localhost;
>>      location / {
>>          root   /usr/share/nginx/html;
>>          index  index.html index.htm;
>>      }
>>      error_page   500 502 503 504  /50x.html;
>>      location = /50x.html {
>>          #root   /usr/share/nginx/html;
>>          root   /ramdisk;
>>     }
>>      location /1KB.json {
>>                 return 202 '{"status":"success","result":"\
>>                             Hello from  NGINX, 2KB test\
>>                             Nanchang, which was the capital of 
>> Yuzhang Prefecture during the HanDynasty, \
>>                             now falls under the jurisdiction of 
>> Hongzhou. It straddles the borderof the \
>>                             influence of the Ye and Zhen 
>> constellations , and is adjacent to theHeng \
>>                             and the Lu mountains . The three rivers 
>> enfold it like the frontpart \
>>                             of a garment and the five lakes encircle 
>> it like a girdle. Itcontrols \
>>                             nature’s jewels. The radiance of its 
>> legendary sword shootsdirectly upward \
>>                             between the constellations Niu and Dou. 
>> Its talented peopleare outstanding,\
>>                             and the spirit of intelligence pervades 
>> the place. This wasthe place where Xu \
>>                             Ru spent the night on his visit to Chen 
>> Fan (10). The mightyHongzhou spreads \
>>                             meteors chasing one another.\
>>                             "}';
>>            }
>>   }
>> }
>
>
> Thanks,
>
> Ethan
>
Please ignore this report, looks like negtive, a running out of rcache 
case.


Thanks,

Ethan


