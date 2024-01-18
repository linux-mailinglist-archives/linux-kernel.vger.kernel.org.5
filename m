Return-Path: <linux-kernel+bounces-30596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1B8832172
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90B8B21AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C8D328B3;
	Thu, 18 Jan 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="C7hf85Q6"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BE328A6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616040; cv=none; b=PEDmJ6rWrwzNicSOXeDVmt/v5qCbXxbrVjTuyEMLGNnI7nEVQFW7J/TN+uccXEIpb4x3RXtKOsO5a3XPjbr/MSydd4z7SwZnofI+rzLfNnUeG/H17O7u8DolkzLXlI97mvgaJreDAD3pjp3dT7+h5XcQwFonYebjs03LZkIcHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616040; c=relaxed/simple;
	bh=XdZsHr1EZ01Wt+FUG5x51/9Se77Wx2keVCDZhiFIx1E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Pd2IqCEG2fAXjLGQqduSWdbz5Z7pxPsfDT+lBwXrzVAeuwmuqt+uHfoFHOVa9G2vHXttYBeLotuTD26qebLkViokbQLP9b3Bi+7M+InhIkZKJfIaJ+ytiJ8CcTC6Ls5kkSKRDow+av0eXVpXKA5KBZMvrYC9dlnPK6OFHqGWEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=C7hf85Q6; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3rDBXomoCyVxTTKAMJ+LkLbnF54btdJlwGWxgDXIy5k=;
  b=C7hf85Q6LAVnRaeYs3NY1+OVRrxuTmbDF6Rqh48v7CFsqC10oSd2wCRL
   U23lXee9MK0GjvKTeU9mpv/Wdi1M5JnTrd1AfsZBte3adynlpgrI+14DU
   7ovwq/WePmDi9vEPCDN49m6xoaECewEHjwhpHXjsLlbMP/nmpbTlRptZL
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,203,1701126000"; 
   d="pdf'?scan'208";a="147475586"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:13:52 +0100
Date: Thu, 18 Jan 2024 23:13:52 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vincent Guittot <vincent.guittot@linaro.org>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <CAKfTPtA31Z0N9hd4z_GPvoZwK=KTf4fPbx_jDbK653mdVDLEbw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2401182304170.3296@hadrien>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com> <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr> <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com>
 <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr> <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com> <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr> <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com>
 <edbd8ecd-148c-b366-fd46-3531dec39d49@inria.fr> <cecfd395-f067-99e1-bdd2-fec2ebc3db3@inria.fr> <CAKfTPtCAcHuzhcDvry6_nH2K29wc-LEo2yOi-J-mnZkwMvGDbw@mail.gmail.com> <cfae246d-9383-59d-ee5b-81ea3dd0a795@inria.fr> <CAKfTPtD0B29zadkeEOCWvry123zWVEEm41ouKj7noXwQdoh2+Q@mail.gmail.com>
 <7a845b43-bd8e-6c7d-6bca-2e6f174f671@inria.fr> <36f2cc93-db10-5977-78ab-d9d07c3f445@inria.fr> <CAKfTPtA31Z0N9hd4z_GPvoZwK=KTf4fPbx_jDbK653mdVDLEbw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1675373435-1705616033=:3296"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1675373435-1705616033=:3296
Content-Type: text/plain; charset=US-ASCII



On Thu, 18 Jan 2024, Vincent Guittot wrote:

> Hi Julia,
>
> Sorry for the delay. I have been involved on other perf regression
>
> On Fri, 5 Jan 2024 at 18:27, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Fri, 5 Jan 2024, Julia Lawall wrote:
> >
> > >
> > >
> > > On Fri, 5 Jan 2024, Vincent Guittot wrote:
> > >
> > > > On Fri, 5 Jan 2024 at 15:51, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > >
> > > > > > Your system is calling the polling mode and not the default
> > > > > > cpuidle_idle_call() ? This could explain why I don't see such problem
> > > > > > on my system which doesn't have polling
> > > > > >
> > > > > > Are you forcing the use of polling mode ?
> > > > > > If yes, could you check that this problem disappears without forcing
> > > > > > polling mode ?
> > > > >
> > > > > I expanded the code in do_idle to:
> > > > >
> > > > >                 if (cpu_idle_force_poll) { c1++;
> > > > >                         tick_nohz_idle_restart_tick();
> > > > >                         cpu_idle_poll();
> > > > >                 } else if (tick_check_broadcast_expired()) { c2++;
> > > > >                         tick_nohz_idle_restart_tick();
> > > > >                         cpu_idle_poll();
> > > > >                 } else { c3++;
> > > > >                         cpuidle_idle_call();
> > > > >                 }
> > > > >
> > > > > Later, I have:
> > > > >
> > > > >         trace_printk("force poll: %d: c1: %d, c2: %d, c3: %d\n",cpu_idle_force_poll, c1, c2, c3);
> > > > >         flush_smp_call_function_queue();
> > > > >         schedule_idle();
> > > > >
> > > > > force poll, c1 and c2 are always 0, and c3 is always some non-zero value.
> > > > > Sometimes small (often 1), and sometimes large (304 or 305).
> > > > >
> > > > > So I don't think it's calling cpu_idle_poll().
> > > >
> > > > I agree that something else
> > > >
> > > > >
> > > > > x86 has TIF_POLLING_NRFLAG defined to be a non zero value, which I think
> > > > > is sufficient to cause the issue.
> > > >
> > > > Could you trace trace_sched_wake_idle_without_ipi() ans csd traces as well ?
> > > > I don't understand what set need_resched() in your case; having in
> > > > mind that I don't see the problem on my Arm systems and IIRC Peter
> > > > said that he didn't face the problem on his x86 system.
> > >
> > > TIF_POLLING_NRFLAG doesn't seem to be defined on Arm.
> > >
> > > Peter said that he didn't see the problem, but perhaps that was just
> > > random.  It requires a NUMA move to occur.  I make 20 runs to be sure to
> > > see the problem at least once.  But another machine might behave
> > > differently.
> > >
> > > I believe the call chain is:
> > >
> > > scheduler_tick
> > >   trigger_load_balance
> > >     nohz_balancer_kick
> > >       kick_ilb
> > >         smp_call_function_single_async
> > >           generic_exec_single
> > >             __smp_call_single_queue
> > >               send_call_function_single_ipi
> > >                 call_function_single_prep_ipi
> > >                   set_nr_if_polling <====== sets need_resched
> > >
> > > I'll make a trace to reverify that.
> >
> > This is what I see at a tick, which corresponds to the call chain shown
> > above:
> >
> >           bt.B.x-4184  [046]   466.410605: bputs:                scheduler_tick: calling trigger_load_balance
> >           bt.B.x-4184  [046]   466.410605: bputs:                trigger_load_balance: calling nohz_balancer_kick
> >           bt.B.x-4184  [046]   466.410605: bputs:                trigger_load_balance: calling kick_ilb
> >           bt.B.x-4184  [046]   466.410607: bprint:               trigger_load_balance: calling smp_call_function_single_async 22
> >           bt.B.x-4184  [046]   466.410607: bputs:                smp_call_function_single_async: calling generic_exec_single
> >           bt.B.x-4184  [046]   466.410607: bputs:                generic_exec_single: calling __smp_call_single_queue
> >           bt.B.x-4184  [046]   466.410608: bputs:                __smp_call_single_queue: calling send_call_function_single_ipi
> >           bt.B.x-4184  [046]   466.410608: bputs:                __smp_call_single_queue: calling call_function_single_prep_ipi
> >           bt.B.x-4184  [046]   466.410608: bputs:                call_function_single_prep_ipi: calling set_nr_if_polling
> >           bt.B.x-4184  [046]   466.410609: sched_wake_idle_without_ipi: cpu=22
>
> I don't know if you have made progress on this in the meantime.
>
> Regarding the trace above, do you know if anything happens on CPU22
> just before the scheduler tried to kick the ILB on it ?
>
> Have you found why TIF_POLLING_NRFLAG seems to be always set when the
> kick_ilb happens ? It should be cleared once entering the idle state.

I haven't figured out everything, but the attached graph shows
that TIF_POLLING_NRFLAG is not always set.  Sometimes it is and sometimes
it isn't.

In the graph, on core 57, the blue box and the green x are before and
after the call to cpuidle_idle_call(), resplectively.  One can't see it in
this graph, but the green x comes before the blue box.  So almost all of
the time, it is in cpuidle_idle_call(), only in the tiny gap between the x
and the box is it back in do_idle with TIF_POLLING_NRFLAG set.

Afterwards, there is a diamond for the polling case and a triangle for the
non polling case.  These also occur on clock ticks, and may be
microscopically closer to (polling) or further from (not polling) the
green x and blue box.

I haven't yet studied what happens afterwards in the non polling case.

julia

>
> Could you check your cpuidle driver ?
>
> Vincent
>
> >
> > julia
>
--8323329-1675373435-1705616033=:3296
Content-Type: application/pdf; name=current_graph.pdf
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.22.394.2401182313520.3296@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=current_graph.pdf

JVBERi0xLjUKJcfsj6IKJSVJbnZvY2F0aW9uOiBncyAtcSAtZFNBRkVSIC1k
Tk9QQVVTRSAtZEJBVENIIC1kQ29tcGF0aWJpbGl0eUxldmVsPTEuNSAtc0RF
VklDRT1wZGZ3cml0ZSAtc091dHB1dEZpbGU9PyAtZFBERlNFVFRJTkdTIy9w
cmVwcmVzcyAtZE1heFN1YnNldFBjdD0xMDAgLWRTdWJzZXRGb250cz10cnVl
IC1kRW1iZWRBbGxGb250cz10cnVlIC1kQXV0b1JvdGF0ZVBhZ2VzIy9Ob25l
IC0KNSAwIG9iago8PC9MZW5ndGggNiAwIFIvRmlsdGVyIC9GbGF0ZURlY29k
ZT4+CnN0cmVhbQp4nK1aWW8kNw5+719RLwt4gEyt7iNAXgIsFshbYr/tLBoT
uz120D7i8WD//lIUKbGu6fGBHG6SHz+pJJZEUfX3oEY9qPIP/b282/3zjzh8
+bqLw/92evgN/vtrp4Z/76xWg0lquNsFFevP4+5cqPGXrdqUAmnxV6ha7YIh
df1JeqNsIn39yfqgHevxZ+A2Ux5zbu2SRG3bGLywskS+zjrdrU1ia9ZRWFki
q3fZdmuTyBpUgH6kNkgkUa/U8GX3907jWA/05/Ju+PUCxjsNebi43tUZ0OAy
auMH7cYwXNzt/nNmR6s+fLTKOKAskpeSUx/+e/Eb0GgkLkRaj9EOH2HILq52
Z38+j7+Oz/urzzffPpp9GOP+8fB0/fB09/n+8rDXeX/99HC3B9r9t8fnB/jh
fhqeb+8Ow6ezr4fLTx9+Gq6+PX1+vn24/3kozRmj44eLv3b/utj9Pp9/53pY
WG1HY3HymsC24PzobS7G3CW25hjH5BK5ssRWDf8btSdflpo1ODO6QL4sNWuO
boyRfUlqgWxVHBW3y1Kx/uDU6TR6GI4xwKPC1J2pMk4fHShDgG7oiBNiUK1I
Z1HnJrqKC6gTE1ua+FjaCqMNSodBmwBDg01dPjwd2qxo7M0f9NY6Feoze+VC
iQzW1MDUFTo3IjyOIUzgjXlu5HVhjbqObbSjd+W1SjqMOTYN0cIgqQKem9Eh
Fk7p0LjnRu7HBCtHwzo1Wt1GIzcNP57qo5Gn8PrAAq4Wo9Hg1IsJdvQ5B5X7
j9Ynjjvy6oE3HUMDD5V8w5E46XjFQbOwwDZcFVuYawh73WlIxOZGm3NWZug/
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
H7Jnfx8tieiPuQRbj8La2n+bv8wm+GMr/EwANZ6+t+qZQ2waxmTS3NQqyDtx
8S0eZCa6VPDxc5REX7vgRx5FEwx98KKtnWCOlJHUS7VXEWAfyuk/6TqY5eYu
kYijh9UCtmKLL4EjP1UEMsRsvXzECz3QaGXppprrCIzBhl7lh7sA1Q109vx9
abkTRE2m78O42sCYI1bCX+OH71c5sUH2Ark7XZXipVbRBL4txXOewByxLvsa
P2yxnKHg7Co8yzVX0XTP8lNgsMVX+eE7pArADNHQdbhXrioC3YjDKUgijlg8
fbETtlVOPDa1dY4+QgJNX9fwnCQw2Nyr/LDFcjQKgcMav1EKbW/Hk1QI/S14
EfxGXqEFo/ATIrN6ebZifdHn6sHAuuvy6PEz5KuH/e3V8fDz8Ofh+uHpMBRh
uPx8PA6fzkwefhms+8enD+1D5VbErb2wGb9fMa58bGTrxyvVUiS2FFSxvKSD
No1x2sHP18+Hp1P9a+c46p/C74KMKd8FpfJREPVI1d9Fb03gowCf3V7u/PIZ
gNNorh+Cw8Psr7/dX5Yv9vdfb++/HA/7x6fD4/728fbn4evhebg/HK5gnr9e
3sDfT2eQUP4Cq8v8uSl2HH7NlHrXdcLuKtJP9oQfgb/m6cr5/Uee7v7heXh8
OB5BDw9W5lMr+Vy/7/4PQM8OyGVuZHN0cmVhbQplbmRvYmoKNiAwIG9iagoy
OTMzCmVuZG9iago0IDAgb2JqCjw8L1R5cGUvUGFnZS9NZWRpYUJveCBbMCAw
IDg0NCAyNDZdCi9QYXJlbnQgMyAwIFIKL1Jlc291cmNlczw8L1Byb2NTZXRb
L1BERiAvVGV4dF0KL0V4dEdTdGF0ZSAxMiAwIFIKL0ZvbnQgMTMgMCBSCj4+
Ci9Db250ZW50cyA1IDAgUgo+PgplbmRvYmoKMyAwIG9iago8PCAvVHlwZSAv
UGFnZXMgL0tpZHMgWwo0IDAgUgpdIC9Db3VudCAxCj4+CmVuZG9iagoxIDAg
b2JqCjw8L1R5cGUgL0NhdGFsb2cgL1BhZ2VzIDMgMCBSCi9NZXRhZGF0YSAx
NiAwIFIKPj4KZW5kb2JqCjcgMCBvYmoKPDwvVHlwZS9FeHRHU3RhdGUKL1NB
IGZhbHNlPj5lbmRvYmoKMTIgMCBvYmoKPDwvUjcKNyAwIFI+PgplbmRvYmoK
MTMgMCBvYmoKPDwvUjgKOCAwIFIvUjEwCjEwIDAgUj4+CmVuZG9iago4IDAg
b2JqCjw8L0Jhc2VGb250L05YSlNaWStUaW1lcy1Sb21hbi9Gb250RGVzY3Jp
cHRvciA5IDAgUi9UeXBlL0ZvbnQKL0ZpcnN0Q2hhciAzMi9MYXN0Q2hhciAx
MTcvV2lkdGhzWwoyNTAgMCAwIDAgMCA4MzMgMCAwIDMzMyAzMzMgMCAwIDAg
MCAyNTAgMAo1MDAgNTAwIDUwMCA1MDAgNTAwIDUwMCA1MDAgMCAwIDUwMCAy
NzggMCAwIDU2NCAwIDAKMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAg
MAowIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCA1MDAKMCA0NDQgNTAw
IDQ0NCA1MDAgNDQ0IDMzMyA1MDAgNTAwIDI3OCAwIDAgMjc4IDAgNTAwIDUw
MAo1MDAgMCAzMzMgMzg5IDI3OCA1MDBdCi9FbmNvZGluZy9XaW5BbnNpRW5j
b2RpbmcvU3VidHlwZS9UeXBlMT4+CmVuZG9iagoxMCAwIG9iago8PC9CYXNl
Rm9udC9ZV0NNVkcrVGltZXMtQm9sZC9Gb250RGVzY3JpcHRvciAxMSAwIFIv
VHlwZS9Gb250Ci9GaXJzdENoYXIgMzIvTGFzdENoYXIgMTE3L1dpZHRoc1sK
MjUwIDAgMCAwIDAgMCAwIDAgMzMzIDMzMyAwIDAgMjUwIDMzMyAyNTAgMAo1
MDAgNTAwIDUwMCA1MDAgNTAwIDAgNTAwIDUwMCAwIDUwMCAzMzMgMCAwIDAg
MCAwCjAgMCA2NjcgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMAowIDAgMCAw
IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCA1MDAKMCA1MDAgNTU2IDQ0NCA1NTYg
NDQ0IDMzMyAwIDU1NiAyNzggMCAwIDAgODMzIDU1NiA1MDAKNTU2IDAgNDQ0
IDM4OSAzMzMgNTU2XQovRW5jb2RpbmcvV2luQW5zaUVuY29kaW5nL1N1YnR5
cGUvVHlwZTE+PgplbmRvYmoKOSAwIG9iago8PC9UeXBlL0ZvbnREZXNjcmlw
dG9yL0ZvbnROYW1lL05YSlNaWStUaW1lcy1Sb21hbi9Gb250QkJveFswIC0y
MTggNzcyIDY4OF0vRmxhZ3MgMzIKL0FzY2VudCA2ODgKL0NhcEhlaWdodCA2
ODgKL0Rlc2NlbnQgLTIxOAovSXRhbGljQW5nbGUgMAovU3RlbVYgMTE1Ci9N
aXNzaW5nV2lkdGggMjUwCi9YSGVpZ2h0IDQ2MAovQ2hhclNldCgvYS9iL2Mv
Y29sb24vZC9lL2VxdWFsL2YvZml2ZS9mb3VyL2cvaC9pL2wvbi9uaW5lL28v
b25lL3AvcGFyZW5sZWZ0L3BhcmVucmlnaHQvcGVyY2VudC9wZXJpb2Qvci9z
L3NpeC9zcGFjZS90L3RocmVlL3R3by91L3VuZGVyc2NvcmUvemVybykvRm9u
dEZpbGUzIDE0IDAgUj4+CmVuZG9iagoxNCAwIG9iago8PC9GaWx0ZXIvRmxh
dGVEZWNvZGUKL1N1YnR5cGUvVHlwZTFDL0xlbmd0aCAzMjk1Pj5zdHJlYW0K
eJydVmtUU9e23iGQvRFqFdwC2mZTe6ptrYpWa6m2YgEflaqAyEuNIOFNAoQQ
JQQSCIFk8ZL3QwgQkgABwkvkKaKCoK0tUkXUI9rWHlvPGa2nvXdtxvKOcXfo
GePcMc6/+2/vtfaec37f+r45FwuztsJYLJb9sZgEvmiTnzAhTGB5f59ey6Lf
sKLfZAMkWKxa9LKhufYYsGcDe+uGN177xQE+WgmrX4epKzBrFmvnocDKdwP8
At/buPEDT2HiueSYqOgU121uW7e7hp9z/deOqxdfFBMlcF3PPKTy44WJCXxB
yuGYhHCxyHUpr6sfP0ocH5b8f9f+He3/Fx/DsLcEwsRkUYo4LPxMBD8yKjom
ftuH23d85Or+yTufvvveZp7bVgw7gh3FfDF/7BgWgB3HPsc8MS/MG9uH7ccO
YAexL7AvMUdsFUZiqzEnjIWtwdZiHIyL2WLLsNcxD2wl5oCtY2jErDExNs76
nNVg9Z5VqtUjdgb7e+tPrAdsnGxSON6cEXwVfgTXE5uIGOIHWz/bANurtmjZ
j3ZWdvvt8u3a7UbtufYhsHA5nQe0NHmV9XABei2w61bD6BpOcKG0CpgJ2IEP
DzRWtgNiRBd/kEJ8XP1FpjQkj0iHETV4SLG8UjNCwHP4z7xre0/Gpx3az32A
KwsCz8bIA9Nd0vCSwrL8CkAYy9JDKJSPa47KM4LzCCahwkhvM7JansHqZ2xY
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
HXCzkeE9NboSZrg3lKXHUa+CcbVPmmyPhlguq6aPl8NT1ZzuZY/tugvt7R8U
2b+GYf8LCgeqFAplbmRzdHJlYW0KZW5kb2JqCjExIDAgb2JqCjw8L1R5cGUv
Rm9udERlc2NyaXB0b3IvRm9udE5hbWUvWVdDTVZHK1RpbWVzLUJvbGQvRm9u
dEJCb3hbMCAtMjA1IDgxNCA2OTRdL0ZsYWdzIDMyCi9Bc2NlbnQgNjk0Ci9D
YXBIZWlnaHQgNjc2Ci9EZXNjZW50IC0yMDUKL0l0YWxpY0FuZ2xlIDAKL1N0
ZW1WIDEyMgovTWlzc2luZ1dpZHRoIDI1MAovWEhlaWdodCA0NzMKL0NoYXJT
ZXQoL0IvYS9iL2MvY29sb24vY29tbWEvZC9lL2YvZm91ci9oL2h5cGhlbi9p
L20vbi9uaW5lL28vb25lL3AvcGFyZW5sZWZ0L3BhcmVucmlnaHQvcGVyaW9k
L3Ivcy9zZXZlbi9zaXgvc3BhY2UvdC90aHJlZS90d28vdS91bmRlcnNjb3Jl
L3plcm8pL0ZvbnRGaWxlMyAxNSAwIFI+PgplbmRvYmoKMTUgMCBvYmoKPDwv
RmlsdGVyL0ZsYXRlRGVjb2RlCi9TdWJ0eXBlL1R5cGUxQy9MZW5ndGggMjk0
OT4+c3RyZWFtCnicnVZpWFNXGr4xkHtESpX0SlFMsCqiYkGlbnWhLnUHVBRU
tgBhDyBhF8K+yAm7rAEiJoDGILJvUlxAi7XIaKvWUUc7My6dZ6aOnWe+Sw9P
n7nB+kx/dP7Mv+Tc73zL+73f+x0eZTSN4vF4M9xCZFL58i2R4QGGv0vZuTzW
aho7j4+JZOLqxG5jVmRKYVM+NjU6Y2U6YQ4PZkH5+xA9kzLi8dbsdDtle+iA
+5Jly+y2RkYlRocEBcdYr3RY4Wjtl2j96xfrbVJ5SFCEtQ33I04aHhklk0bE
OIfI/GLl1gciZZIIa0Pw3x7819X/55yiqPkRWyKjouUxsRI//wBpYHCIbOUq
x9XWa9att11it/xjH4cVFOVCLaBcqf3UQcqNOkQdprZQW6lt1Hbqc2oHtYva
TTlTQuoDiqEsKB71ITWHmktNp0yo9ygz6n3KiZpFmVMfcRBSRlQS9TPvM96V
aXOnqaY95G/i3zVaYZRmNGnsYdwrWCpQ0A50OTJDHugWuo3Y6XHTW6eDyWaT
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
AAsshK+5OS9j2O2f0q6biDlZu8POxc6SGIOSLKQ5CiyChTeBz21d4jebSAUg
hUGDMiqa4JdewGpeM7fexWDHZ0MntjHEMmFvrJM7MdrkSowwsUTks+ecq/kw
8/k/wAre2/IdEYTF5ipkoouw+MkjsDmHSDppZ8bOHCKriGlqxFF5Unl9ujhJ
n/4NfolHS4ZLi8tKqopqMLcwCqcKYFUwj8cen1jLTDoKfEi0sVZQO3pWM5SP
wF9APCdbjX8QGPJTA+6FX5p4jWDH5efA1ykYsFbf1n53/Z/3rwCFQYjgM3sw
JtZk1gpbMo+YfPMp8No1xdXNIl9it34DWRjBuZywYhqxKr1SXhNVvg1vw1En
w/K8TypwRn5uviI/J+9kZk5ibjJG+2JGYCWgynOciMIzBffGWQwbeY9hIx/W
gwPjJZV6HWsN7B9oa+0fkLZ5imHciDvzPtoaONDf1tbXbzjjLk6sVvP6wJgP
1yd2M/tCI+MC/FbbexETTGZje63jwKa+rd3+f3dFzfSBi9HauF7ZaMoLDPMw
iKt/bL6h7tE23uhAv/qBLZyjJrKBGdU3n27vevq8D2ZgYPDz6D8fe+B117dj
yXUUSQ8HaY+f9j63r9oek3mYiFJsIl3ifaKPu/gbIM9WJ8Iqc7C/bSH0HSY7
GUBjg1/jZ2jcr9/lSGiYh0h42utsWE9xCVaWiIS+ysICXDC3oiwjNSBE4uRu
qAg2A+L1QC4fOqCDIbkEQa6A88xBxOs0wDPr9+DhOkgWjPPYXLKAGZ/M/tww
NYrmCctmnoaD2QpW8qGQ49tuvMvHb2uYW+xyvBYR/1ecbllyDztu0XiD51JY
RhjR7clABrtmbsyISos4kcI9Z44kjMASMSTSYFc3fOmSeh9Z/HY0Jqw4zJzB
ls86a5gVykQVfoDYsSSaFBOe8XH6VGFpYVFBU7m2tAojbUWsp3iSoZXr4xJt
85GcnUGbJdSzkkrwqRHoTUA0Q19sagqictP3KOo/H2MyNAplbmRzdHJlYW0K
ZW5kb2JqCjE2IDAgb2JqCjw8L1R5cGUvTWV0YWRhdGEKL1N1YnR5cGUvWE1M
L0xlbmd0aCAxMTcxPj5zdHJlYW0KPD94cGFja2V0IGJlZ2luPSfvu78nIGlk
PSdXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQnPz4KPD9hZG9iZS14YXAtZmls
dGVycyBlc2M9IkNSTEYiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSdhZG9iZTpu
czptZXRhLycgeDp4bXB0az0nWE1QIHRvb2xraXQgMi45LjEtMTMsIGZyYW1l
d29yayAxLjYnPgo8cmRmOlJERiB4bWxuczpyZGY9J2h0dHA6Ly93d3cudzMu
b3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMnIHhtbG5zOmlYPSdodHRw
Oi8vbnMuYWRvYmUuY29tL2lYLzEuMC8nPgo8cmRmOkRlc2NyaXB0aW9uIHJk
ZjphYm91dD0iIiB4bWxuczpwZGY9J2h0dHA6Ly9ucy5hZG9iZS5jb20vcGRm
LzEuMy8nIHBkZjpQcm9kdWNlcj0nR1BMIEdob3N0c2NyaXB0IDEwLjAyLjEn
Lz4KPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSdo
dHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvJz48eG1wOk1vZGlmeURhdGU+
MjAyNC0wMS0xOFQyMzowMjoyMiswMTowMDwveG1wOk1vZGlmeURhdGU+Cjx4
bXA6Q3JlYXRlRGF0ZT4yMDI0LTAxLTE4VDIzOjAyOjIyKzAxOjAwPC94bXA6
Q3JlYXRlRGF0ZT4KPHhtcDpDcmVhdG9yVG9vbD5qZ3JhcGg8L3htcDpDcmVh
dG9yVG9vbD48L3JkZjpEZXNjcmlwdGlvbj4KPHJkZjpEZXNjcmlwdGlvbiBy
ZGY6YWJvdXQ9IiIgeG1sbnM6eGFwTU09J2h0dHA6Ly9ucy5hZG9iZS5jb20v
eGFwLzEuMC9tbS8nIHhhcE1NOkRvY3VtZW50SUQ9J3V1aWQ6Y2UyZjJjOTkt
ZWU2OS0xMWY5LTAwMDAtMTdlYzM0NDc5NTBmJy8+CjxyZGY6RGVzY3JpcHRp
b24gcmRmOmFib3V0PSIiIHhtbG5zOmRjPSdodHRwOi8vcHVybC5vcmcvZGMv
ZWxlbWVudHMvMS4xLycgZGM6Zm9ybWF0PSdhcHBsaWNhdGlvbi9wZGYnPjxk
Yzp0aXRsZT48cmRmOkFsdD48cmRmOmxpIHhtbDpsYW5nPSd4LWRlZmF1bHQn
PlVudGl0bGVkPC9yZGY6bGk+PC9yZGY6QWx0PjwvZGM6dGl0bGU+PC9yZGY6
RGVzY3JpcHRpb24+CjwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKPD94cGFja2V0IGVuZD0ndyc/PgplbmRzdHJlYW0KZW5kb2JqCjIgMCBv
YmoKPDwvUHJvZHVjZXIoR1BMIEdob3N0c2NyaXB0IDEwLjAyLjEpCi9DcmVh
dGlvbkRhdGUoRDoyMDI0MDExODIzMDIyMiswMScwMCcpCi9Nb2REYXRlKEQ6
MjAyNDAxMTgyMzAyMjIrMDEnMDAnKQovQ3JlYXRvcihqZ3JhcGgpPj5lbmRv
YmoKeHJlZgowIDE3CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMzQ2MSAw
MDAwMCBuIAowMDAwMDEyODIwIDAwMDAwIG4gCjAwMDAwMDM0MDIgMDAwMDAg
biAKMDAwMDAwMzI1MSAwMDAwMCBuIAowMDAwMDAwMjI4IDAwMDAwIG4gCjAw
MDAwMDMyMzEgMDAwMDAgbiAKMDAwMDAwMzUyNiAwMDAwMCBuIAowMDAwMDAz
NjQxIDAwMDAwIG4gCjAwMDAwMDQ0MjggMDAwMDAgbiAKMDAwMDAwNDAzNCAw
MDAwMCBuIAowMDAwMDA4MTczIDAwMDAwIG4gCjAwMDAwMDM1NzAgMDAwMDAg
biAKMDAwMDAwMzYwMCAwMDAwMCBuIAowMDAwMDA0NzkzIDAwMDAwIG4gCjAw
MDAwMDg1MzggMDAwMDAgbiAKMDAwMDAxMTU3MiAwMDAwMCBuIAp0cmFpbGVy
Cjw8IC9TaXplIDE3IC9Sb290IDEgMCBSIC9JbmZvIDIgMCBSCi9JRCBbPDVF
RUI1NkEyMkYxRERBQTA1MUQxNkU2N0YwMDhGRTE2Pjw1RUVCNTZBMjJGMURE
QUEwNTFEMTZFNjdGMDA4RkUxNj5dCj4+CnN0YXJ0eHJlZgoxMjk2MwolJUVP
Rgo=

--8323329-1675373435-1705616033=:3296--

