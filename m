Return-Path: <linux-kernel+bounces-152152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297AA8AB9EE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEBE1F2140A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD7EFC1C;
	Sat, 20 Apr 2024 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="TXaqhKH6"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137637465
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713592688; cv=none; b=Z1lBaQh7LNEcjA8Tkg5FsvE7cZzdvBeo+F9Ff66DY4WEflHjwzDXvEGLfMTN2Kkkb3+LOc9otAWE3brqbIhyJMoqNr8Zu4l9Za2ZTavzk6IikgLIhRtPahSs9Yqp40mJ9LEiLbCsD9tsm/+egi1tZeXMy+dfexZCldfiag84gqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713592688; c=relaxed/simple;
	bh=SkGSZ7gMisUTlLlglammovEf9aExQFDJOL0lbghMVC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uBdor+MsrxK9YqT+k1HQMrUHSVKVW3ztPMFsPAvBRWqfR8NCl9jTjd83ibmrBoWV3+G6b2mn/dDO5w9+uIRNflqZycExziaSJpw2RKI5UnGDouykgfG5QzNm/Pquab5shg36au5GFqQolP+0Tw96/1FRta6d+Ag6KcJRapS43VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=TXaqhKH6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713592642; x=1714197442; i=efault@gmx.de;
	bh=LjfTmEV4dNI6LexaD35ltYWeUzSMwN0iQ8POX1r7Vs8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TXaqhKH64pcodV/2YvHXZ45gqZsytwWKrBkD2gX7duB2JLLPRTqhfz9EgZYxWLEL
	 Zj0gB9TC5RPytVFn5D0WqmKbQ3wwimLTTvKDGPUknScIVRTI4/MtC5fLXt2yp06wL
	 YuH0eUDijj+rOdztijhF0IfVcyM+b3S/9uV30Vp4jzmdjsFnZ30KbmdULhJu+1gEF
	 lU3NBb/ofjCJfvVMNg5ipzRDKZYywJo1BMRDfmm5AGP3b7pIgG6+hdpwUekV48LBo
	 HaxcIITHH4dZKKZLx2WnX3pvnlsvtFN1ThnuXcPfWAYKz1TcO6Ku2XKFhDvk1ynmT
	 oWm561k3Irm3wwp+0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.150.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1sJ9DV3FwZ-00Mql2; Sat, 20
 Apr 2024 07:57:22 +0200
Message-ID: <6b2487403dafb09fbdfb0075123fc3fda8ab7636.camel@gmx.de>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com,  vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: "kprateek.nayak" <kprateek.nayak@amd.com>, tglx@linutronix.de
Date: Sat, 20 Apr 2024 07:57:21 +0200
In-Reply-To: <20240405110010.631664251@infradead.org>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.631664251@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2We3pv0AW+IyFfYhCJeXsxkWmLBS4NCWgJOo7Ibml0tb5B3kvwe
 +oMabgLW7MHC/ApSYo4h+T7xZ7jTnNMCKG5TqHbUbMEUg+VojSblIXUvsaYeUygilI3qylG
 G1zkQ8mgocvANiNDJwt0wHMRHAYWErq+4jBsBug14fOsPz17Cjgnb6T5sv1lkLc0IPbEUr8
 ChGu2JlWUY5zUMQMX9Pnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:toGnqYiqh2M=;UdCW03HA+SW2hkNU6yJbikJDfKd
 R0llb77tczDkenXy5gSHIJgf54UaIlQA7Q2U1oqb5+mZwLyPzVyMh0jR5vlSCl9dHRenN2b9a
 qUm471hqTyU7sB9wktILlNV1Z6TsxLcNDURxOuHYjhxXOtFeK+BOkc0hrNjt4xRMDwYYmJ2O3
 audpWF7tOYHqr81MBb6OpHdRJbAQ86+9Vy2uvS9OfVmLhIh9Vl/j/cOevpp7k6VthsEdOuVSP
 f1HPnb4KYtNj5ByKFtZti96Ts5qNWp2/nRB/LYBotcgv0BmmmEebGpx0OEd8srUzO0Yo856Hs
 f4JFGqza/rvSdewk0/ore5IoyZHDkbqY5pmGio9lUoJm+LPHW8/pe/RlQJXsVojzLRsslpTam
 ZN5Rc0+w/8cv8gRFo60vkVQKOAMN/51HLj2Bu/f8wzX93mc+tpcvOSpczuuyQfkroP/eQnqUe
 rxKwiHXnnq4cNObOPxvnDw4BlinTiSeuv2IeRWbkn2Bx2V5V/aXSV8j5amhaT2zJdVVxkSwHG
 mInMSstIyAPD4dpnrd44FEiivfGewgY2dYaBIHY4ztMUOiIwpRq3icGMeww+HzQ1C9NU5BKse
 RXFPDlVkdW2WOEQMFPcrZCv4Ef2im5vofLNCvL5aQ8yDBMGOWSa6F1bhz5Hm9lE/CdgOvhvvi
 8OJ47GAB4FnJ6I1/sLLSyDT6xCMxt/Q3bnuagdM5Z7MTHKuy21oEJ9yMKsR/Vh77yFUrLvjVn
 aYZEvOSbrqAs/phrmOyoe53RK/BxTCkg1/kLg2svn6g54xKMJT+n+AbZWolFFmdFGa/eosTTL
 g5VBEoCbTaRgKK9VIfqJad7E/8/T2xd6VEUEjucD3cvok=

(removes apparently busted bytedance.com address and retries xmit)

Greetings!

With this version, the better CPU distribution (for tbench synchronous
net-blasting) closed the CFS vs EEVDF throughput deficit.  I verified
both by rolling the previous version forward and back-porting to 6.1
where I've got CFS and EEVDF to re-compare, now with both dequeue delay
patch versions.

As usual, there will be winners and losers, but (modulo dead buglet) it
looks kinda promising to me.

Distribution of single pinned buddy pair measured in master:
DELAY_DEQUEUE
 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  tbench:(2)            |   6277.099 ms |  1597104 | avg:   0.003 ms | max=
:   0.129 ms | sum: 4334.723 ms |
  tbench_srv:(2)        |   5724.971 ms |  1682629 | avg:   0.001 ms | max=
:   0.083 ms | sum: 2076.616 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |  12021.128 ms |  3280275 |                 |    =
    1.729 ms |      6425.483 ms |
 -------------------------------------------------------------------------=
---------------------------------
client/server CPU distribution ~52%/48%

NO_DELAY_DEQUEUE
 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  tbench:(2)            |   6724.774 ms |  1546761 | avg:   0.002 ms | max=
:   0.409 ms | sum: 2443.549 ms |
  tbench_srv:(2)        |   5275.329 ms |  1571688 | avg:   0.002 ms | max=
:   0.086 ms | sum: 2734.151 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |  12019.641 ms |  3119000 |                 |    =
 9996.367 ms |     15187.833 ms |
 -------------------------------------------------------------------------=
---------------------------------
client/server CPU distribution ~56%/44%

Note switches and delay sum.  For tbench, they translate directly to
throughput.  The other shoe lands with async CPU hog net-blasters, for
those, scheduler cycles tends to be wasted cycles.

	-Mike

