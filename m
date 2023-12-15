Return-Path: <linux-kernel+bounces-1114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7332A814AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19F2B23A10
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3B364B2;
	Fri, 15 Dec 2023 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+DXRh1D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD86364DF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE582C433CD;
	Fri, 15 Dec 2023 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702651156;
	bh=33M2vrx6UPW+NCsp4u79rR82ThY+lOzFqm0TWaDJXow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+DXRh1DWtI+q7hVxZNcvDsLlFZdABe82o2h2+N0caAE5TjidRJslXbGduvFqTD1+
	 ydFoWVGky/X9Jwh8AjqClszt4107m38AvlirUsJrxNrbjG9mrFZLArb+zMUZDkS1JR
	 UfzufmJk4qk7k0IB6/d19frP246gSreon3JrrdoIt9QVREEXUq3fchwpgKCH6ERA+t
	 Oc/SHP4dl8iRESX5Fq8W4YF3gk92ljskoxyTJjl+9D6do6niWskreixC03f0dRVeRf
	 0aN8O04w3P8hWcw3/E/QhulG58ce89sSsZFU6Qp2xlWkBKyg3oBM2AI2Hwyj7J34vV
	 cVIt+g1AZ2n8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 03C32403EF; Fri, 15 Dec 2023 11:39:13 -0300 (-03)
Date: Fri, 15 Dec 2023 11:39:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: kajoljain <kjain@linux.ibm.com>,
	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
	Ian Rogers <irogers@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: perf tools arch Arm CMN PMU JSON files build breakage on ubuntu
 18.04 cross build
Message-ID: <ZXxlERShV-TIGVit@kernel.org>
References: <ZBxP77deq7ikTxwG@kernel.org>
 <a21aa4e1-506a-916c-03bd-39d7403c7941@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21aa4e1-506a-916c-03bd-39d7403c7941@linux.ibm.com>
X-Url: http://acmel.wordpress.com

Em Mon, Mar 27, 2023 at 09:52:11AM +0530, kajoljain escreveu:
> On 3/23/23 18:41, Arnaldo Carvalho de Melo wrote:
> > Exception processing pmu-events/arch/powerpc/power9/other.json
> > Traceback (most recent call last):
> >   File "pmu-events/jevents.py", line 997, in <module>
> >     main()
> >   File "pmu-events/jevents.py", line 979, in main
> >     ftw(arch_path, [], preprocess_one_file)
> >   File "pmu-events/jevents.py", line 935, in ftw
> >     ftw(item.path, parents + [item.name], action)
> >   File "pmu-events/jevents.py", line 933, in ftw
> >     action(parents, item)
> >   File "pmu-events/jevents.py", line 514, in preprocess_one_file
> >     for event in read_json_events(item.path, topic):
> >   File "pmu-events/jevents.py", line 388, in read_json_events
> >     events = json.load(open(path), object_hook=JsonEvent)
> >   File "/usr/lib/python3.6/json/__init__.py", line 296, in load
> >     return loads(fp.read(),
> >   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
> >     return codecs.ascii_decode(input, self.errors)[0]
> > UnicodeDecodeError: 'ascii' codec can't decode byte 0xc2 in position 55090: ordinal not in range(128)
> >   CC      /tmp/build/perf/tests/expr.o
> > pmu-events/Build:35: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
> > make[3]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 1
> > make[3]: *** Deleting file '/tmp/build/perf/pmu-events/pmu-events.c'
> > Makefile.perf:679: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
> > make[2]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
> > make[2]: *** Waiting for unfinished jobs....

> > Now jevents is an opt-out feature so I'm noticing these problems.
 
>     Thanks for raising it. I will check this issue.

Now I'm seeing this on:

Exception processing pmu-events/arch/arm64/arm/cmn/sys/cmn.json
Traceback (most recent call last):
  File "pmu-events/jevents.py", line 1285, in <module>
    main()
  File "pmu-events/jevents.py", line 1267, in main
    ftw(arch_path, [], preprocess_one_file)
  File "pmu-events/jevents.py", line 1217, in ftw
    ftw(item.path, parents + [item.name], action)
  File "pmu-events/jevents.py", line 1217, in ftw
    ftw(item.path, parents + [item.name], action)
  File "pmu-events/jevents.py", line 1217, in ftw
    ftw(item.path, parents + [item.name], action)
  File "pmu-events/jevents.py", line 1215, in ftw
    action(parents, item)
  File "pmu-events/jevents.py", line 599, in preprocess_one_file
    for event in read_json_events(item.path, topic):
  File "pmu-events/jevents.py", line 416, in read_json_events
    events = json.load(open(path), object_hook=JsonEvent)
  File "/usr/lib/python3.6/json/__init__.py", line 296, in load
    return loads(fp.read(),
  File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
    return codecs.ascii_decode(input, self.errors)[0]
UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 3071: ordinal not in range(128)


