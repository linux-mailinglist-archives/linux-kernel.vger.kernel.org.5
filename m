Return-Path: <linux-kernel+bounces-16510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B61823F81
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CA0B24167
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0620DDB;
	Thu,  4 Jan 2024 10:35:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583320DCE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 404AYx8J050578;
	Thu, 4 Jan 2024 19:34:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Thu, 04 Jan 2024 19:34:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 404AYxCk050573
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 4 Jan 2024 19:34:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d314e471-0251-461e-988d-70add0c6ebf6@I-love.SAKURA.ne.jp>
Date: Thu, 4 Jan 2024 19:34:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_targets_found
Content-Language: en-US
To: Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: krzysztof.kozlowski@linaro.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000026100c060e143e5a@google.com>
 <20240104050501.2766-1-hdanton@sina.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240104050501.2766-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/04 14:05, Hillf Danton wrote:
> On Wed, 03 Jan 2024 16:59:25 -0800
>> HEAD commit:    453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=141bc48de80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>
> 
> 	syz-executor.1:27827		kworker/u4:93/7607	kworker/0:1/11541
> 	===				===			===
> 	nci_close_device()		nci_rx_work()		nfc_urelease_event_work()
> 	mutex_lock(&ndev->req_lock)				device_lock()
> 	flush_workqueue(ndev->rx_wq)				mutex_lock(&ndev->req_lock)
> 					device_lock()
> 
> Looks like lockdep failed to detect deadlock once more because of device_lock().

Yes, this is yet another circular locking dependency hidden by device_lock().

Calling flush_workqueue(ndev->rx_wq) with ndev->req_lock has to be avoided,
for nci_close_device() has ndev->req_lock => dev->dev dependency and
nfc_urelease_event_work() has dev->dev => ndev->req_lock dependency.

  nci_close_device() {
    mutex_lock(&ndev->req_lock); // ffff88802bed4350
    flush_workqueue(ndev->rx_wq); // wait for nci_rx_work() to complete
    mutex_unlock(&ndev->req_lock); // ffff88802bed4350
  }
  
  nci_rx_work() { // ndev->rx_work is on ndev->rx_wq
    nci_ntf_packet() {
      device_lock(&dev->dev); // ffff88802bed5100
      device_unlock(&dev->dev); // ffff88802bed5100
    }
  }

  nfc_urelease_event_work() {
    mutex_lock(&nfc_devlist_mutex); // ffffffff8ee4d808
    mutex_lock(&dev->genl_data.genl_data_mutex); // ffff88802bed5508
    nfc_stop_poll() {
      device_lock(&dev->dev); // ffff88802bed5100
      nci_stop_poll() {
        nci_request() {
          mutex_lock(&ndev->req_lock); // ffff88802bed4350
          mutex_unlock(&ndev->req_lock); // ffff88802bed4350
        }
      }
      device_unlock(&dev->dev); // ffff88802bed5100
    }
    mutex_unlock(&dev->genl_data.genl_data_mutex); // ffff88802bed5508
    mutex_unlock(&nfc_devlist_mutex); // ffffffff8ee4d808
  }

I consider that we need to enable lockdep validation on dev->dev mutex
( https://lkml.kernel.org/r/c7fb01a9-3e12-77ed-5c4c-db7deb64dc73@I-love.SAKURA.ne.jp )
but was some alternative to my proposal at
https://lkml.kernel.org/r/1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp
proposed? Is it time to retry my proposal?


